
using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;


namespace TAANS
{
    public class VelocityRenderBuffersPass : ScriptableRenderPass
    {
        const string m_ProfilerTag = "VelocityRenderBuffPass";
        static readonly int m_TempTarget3 = Shader.PropertyToID("_TempTarget3");
        private const RenderTextureFormat velocityFormat = RenderTextureFormat.RGFloat;

        private Material m_Material;
        private bool m_IsCameraStereo = false;
        private RenderTargetHandle[] m_VelocityRenderBuffers;
        private RenderTargetHandle[] m_VelocityNeighborMaxRenderBuffers;
        private TAAData m_TAAData;

        private bool[] m_ParamInitialized;
        private Vector4[] m_ParamProjectionExtents;
        private Matrix4x4[] m_ParamCurrV;
        private Matrix4x4[] m_ParamCurrVP;
        private Matrix4x4[] m_ParamPrevVP;
        private Matrix4x4[] m_ParamPrevVPNoFlip;

        private int activeEyeIndex = -1;
        public RenderTargetHandle activeVelocityRenderBuffer
        {
            get
            {
                return (activeEyeIndex != -1) ? m_VelocityRenderBuffers[activeEyeIndex] :
                  RenderTargetHandle.CameraTarget;
            }
        }
        public RenderTargetHandle activeVelocityNeighborMaxRenderBuffer
        {
            get
            {
                return (activeEyeIndex != -1) ? m_VelocityNeighborMaxRenderBuffers[activeEyeIndex] :
                  RenderTargetHandle.CameraTarget;
            }
        }

        public enum NeighborMaxSupport
        {
            TileSize10,
            TileSize20,
            TileSize40,
        };

        public bool neighborMaxGen = false;
        public NeighborMaxSupport neighborMaxSupport = NeighborMaxSupport.TileSize20;

        private float timeScaleNextFrame;
        public float timeScale { get; private set; }

#if UNITY_EDITOR
        [Header("Stats")]
        public int numResident = 0;
        public int numRendered = 0;
        public int numDrawCalls = 0;
#endif

        public VelocityRenderBuffersPass(RenderPassEvent evt)
        {
            this.renderPassEvent = evt;
            m_IsCameraStereo = false;
            Shader shader = Shader.Find("Hidden/Universal Render Pipeline/VelocityBuffer");
            if (shader == null)
                Debug.LogError(string.Format("Hidden/Universal Render Pipeline/VelocityBuffer Not Found"));
            m_Material = new Material(shader);
        }

        public void InitRenderTarget(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor, ref int targetArraySize)
        {
            if (m_VelocityRenderBuffers != null && targetArraySize == m_VelocityRenderBuffers.Length)
                return;
            if (m_VelocityRenderBuffers != null)
            {
                for (int i = 0, n = m_VelocityRenderBuffers.Length; i < n; ++i)
                {
                    cmd.ReleaseTemporaryRT(m_VelocityRenderBuffers[i].id);
                    if (neighborMaxGen && m_VelocityNeighborMaxRenderBuffers != null)
                        cmd.ReleaseTemporaryRT(m_VelocityNeighborMaxRenderBuffers[i].id);
                }
            }

            m_VelocityRenderBuffers = new RenderTargetHandle[targetArraySize];
            m_VelocityNeighborMaxRenderBuffers = new RenderTargetHandle[targetArraySize];

            for (int i = 0; i < targetArraySize; ++i)
            {
                m_VelocityRenderBuffers[i].Init("_VelocityRenderBuffers_" + i);
                m_VelocityNeighborMaxRenderBuffers[i].Init("_VelocityNeighborMaxRenderBuffers_" + i);
            }

            RenderTextureDescriptor descriptor = cameraTextureDescriptor;
            descriptor.depthBufferBits = 0;
            for (int i = 0; i < targetArraySize; ++i)
            {
                cmd.GetTemporaryRT(m_VelocityRenderBuffers[i].id, descriptor);
                if (neighborMaxGen)
                    cmd.GetTemporaryRT(m_VelocityNeighborMaxRenderBuffers[i].id, descriptor);
            }
        }

        public void Setup(TAAData data)
        {
            m_TAAData = data;
        }

        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor textureDescriptor)
        {
            timeScaleNextFrame = Time.timeScale;
            int targetArraySize = m_IsCameraStereo ? 2 : 1;
            EnsureInstance.EnsureArray(ref m_ParamInitialized, targetArraySize, initialValue: false);
            InitRenderTarget(cmd, textureDescriptor, ref targetArraySize);
            EnsureInstance.EnsureArray(ref m_ParamProjectionExtents, targetArraySize);
            EnsureInstance.EnsureArray(ref m_ParamCurrV, targetArraySize);
            EnsureInstance.EnsureArray(ref m_ParamCurrVP, targetArraySize);
            EnsureInstance.EnsureArray(ref m_ParamPrevVP, targetArraySize);
            EnsureInstance.EnsureArray(ref m_ParamPrevVPNoFlip, targetArraySize);
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (m_Material == null)
                return;

            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);

            ref CameraData cameraData = ref renderingData.cameraData;
            Camera camera = renderingData.cameraData.camera;

            timeScale = timeScaleNextFrame;
            timeScaleNextFrame = (Time.timeScale == 0.0f) ? timeScaleNextFrame : Time.timeScale;

#if SUPPORT_STEREO
        int eyeIndex = (camera.stereoActiveEye == Camera.MonoOrStereoscopicEye.Right) ? 1 : 0;
#else
            int eyeIndex = 0;
#endif
            int bufferW = camera.pixelWidth;
            int bufferH = camera.pixelHeight;

            EnsureInstance.EnsureKeyword(m_Material, "CAMERA_PERSPECTIVE", !camera.orthographic);
            EnsureInstance.EnsureKeyword(m_Material, "CAMERA_ORTHOGRAPHIC", camera.orthographic);
            EnsureInstance.EnsureKeyword(m_Material, "TILESIZE_10", neighborMaxSupport == NeighborMaxSupport.TileSize10);
            EnsureInstance.EnsureKeyword(m_Material, "TILESIZE_20", neighborMaxSupport == NeighborMaxSupport.TileSize20);
            EnsureInstance.EnsureKeyword(m_Material, "TILESIZE_40", neighborMaxSupport == NeighborMaxSupport.TileSize40);

#if SUPPORT_STEREO
        if (camera.stereoEnabled)
        {
            for (int i = 0; i != 2; i++)
            {
                Camera.StereoscopicEye eye = (Camera.StereoscopicEye)i;

                Matrix4x4 currV = camera.GetStereoViewMatrix(eye);
                Matrix4x4 currP = GL.GetGPUProjectionMatrix(camera.GetStereoProjectionMatrix(eye), true);
                Matrix4x4 currP_NoFlip = GL.GetGPUProjectionMatrix(camera.GetStereoProjectionMatrix(eye), false);
                Matrix4x4 prevV = m_ParamInitialized[i] ? m_ParamCurrV[i] : currV;

                m_ParamInitialized[i] = true;
                m_ParamProjectionExtents[i] = camera.GetProjectionExtents(eye);
                m_ParamCurrV[i] = currV;
                m_ParamCurrVP[i] = currP * currV;
                m_ParamPrevVP[i] = currP * prevV;
                m_ParamPrevVPNoFlip[i] = currP_NoFlip * prevV;
            }
        }
        else
#endif
            {
                Matrix4x4 currV = camera.worldToCameraMatrix;
                Matrix4x4 currP = GL.GetGPUProjectionMatrix(camera.projectionMatrix, true);
                Matrix4x4 currP_NoFlip = GL.GetGPUProjectionMatrix(camera.projectionMatrix, false);
                Matrix4x4 prevV = m_ParamInitialized[0] ? m_ParamCurrV[0] : currV;

                m_ParamInitialized[0] = true;
                //m_ParamProjectionExtents[0] = frustumJitter.enabled ? camera.GetProjectionExtents(frustumJitter.activeSample.x, frustumJitter.activeSample.y) : camera.GetProjectionExtents();
                m_ParamCurrV[0] = currV;
                m_ParamCurrVP[0] = currP * currV;
                m_ParamPrevVP[0] = currP * prevV;
                m_ParamPrevVPNoFlip[0] = currP_NoFlip * prevV;
            }

            RenderTargetHandle destination = m_VelocityRenderBuffers[eyeIndex];
            {
                //GL.Clear(true, true, Color.black);

                const int kPrepass = 0;
                const int kVertices = 1;
                const int kVerticesSkinned = 2;
                const int kTileMax = 3;
                const int kNeighborMax = 4;

                // 0: prepass 
#if SUPPORT_STEREO
            m_Material.SetVectorArray("_ProjectionExtents", m_ParamProjectionExtents);
            m_Material.SetMatrixArray("_CurrV", m_ParamCurrV);
            m_Material.SetMatrixArray("_CurrVP", m_ParamCurrVP);
            m_Material.SetMatrixArray("_PrevVP", m_ParamPrevVP);
            m_Material.SetMatrixArray("_PrevVP_NoFlip", m_ParamPrevVPNoFlip);
#else
                m_Material.SetVector("_ProjectionExtents", m_ParamProjectionExtents[0]);
                m_Material.SetMatrix("_CurrV", m_ParamCurrV[0]);
                m_Material.SetMatrix("_CurrVP", m_ParamCurrVP[0]);
                m_Material.SetMatrix("_PrevVP", m_ParamPrevVP[0]);
                m_Material.SetMatrix("_PrevVP_NoFlip", m_ParamPrevVPNoFlip[0]);
#endif
                m_Material.SetPass(kPrepass);
                m_Material.SetVector("_VelocityTex_TexelSize",
                    new Vector4(cameraData.cameraTargetDescriptor.width, cameraData.cameraTargetDescriptor.height, 0, 0));
                cmd.Blit(null, destination.Identifier(), m_Material, kPrepass);

                // 1 + 2: vertices + vertices skinned
                var obs = VelocityBufferTag.activeObjects;
#if UNITY_EDITOR
                numResident = obs.Count;
                numRendered = 0;
                numDrawCalls = 0;
#endif
                for (int i = 0, n = obs.Count; i != n; i++)
                {
                    var ob = obs[i];
                    if (ob != null && ob.rendering && ob.mesh != null)
                    {
                        m_Material.SetMatrix("_CurrM", ob.localToWorldCurr);
                        m_Material.SetMatrix("_PrevM", ob.localToWorldPrev);
                        int shaderPass = ob.skinnedMeshRendererActive ? kVerticesSkinned : kVertices;
                        m_Material.SetPass(shaderPass);

                        for (int j = 0; j != ob.mesh.subMeshCount; j++)
                        {
                            cmd.DrawMesh(ob.mesh, Matrix4x4.identity, m_Material, j, shaderPass);
#if UNITY_EDITOR
                            numDrawCalls++;
#endif
                        }
#if UNITY_EDITOR
                        numRendered++;
#endif
                    }
                }

                // 3 + 4: tilemax + neighbormax
                if (neighborMaxGen)
                {
                    int tileSize = 1;

                    switch (neighborMaxSupport)
                    {
                        case NeighborMaxSupport.TileSize10: tileSize = 10; break;
                        case NeighborMaxSupport.TileSize20: tileSize = 20; break;
                        case NeighborMaxSupport.TileSize40: tileSize = 40; break;
                    }

                    int neighborMaxW = bufferW / tileSize;
                    int neighborMaxH = bufferH / tileSize;

                    // tilemax
                    cmd.GetTemporaryRT(m_TempTarget3, neighborMaxW, neighborMaxH, 0, FilterMode.Bilinear, velocityFormat);
                    cmd.SetRenderTarget(m_TempTarget3, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
                    {
                        cmd.SetGlobalTexture("_VelocityTex", m_VelocityRenderBuffers[eyeIndex].Identifier());
                        m_Material.SetVector("_VelocityTex_TexelSize", new Vector4(1.0f / bufferW, 1.0f / bufferH, 0.0f, 0.0f));
                        m_Material.SetPass(kTileMax);
                        EnsureInstance.DrawFullscreenQuad();
                    }

                    // neighbormax
                    RenderTargetHandle tileDestination = m_VelocityNeighborMaxRenderBuffers[eyeIndex];
                    cmd.SetRenderTarget(tileDestination.id, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
                    {
                        cmd.SetGlobalTexture("_VelocityTex", tileDestination.Identifier());
                        m_Material.SetVector("_VelocityTex_TexelSize", new Vector4(1.0f / neighborMaxW, 1.0f / neighborMaxH, 0.0f, 0.0f));
                        m_Material.SetPass(kNeighborMax);
                        EnsureInstance.DrawFullscreenQuad();
                    }
                    cmd.ReleaseTemporaryRT(m_TempTarget3);
                }
            }

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
            activeEyeIndex = eyeIndex;
        }

        public void Cleanup(CommandBuffer cmd)
        {
            if (m_VelocityRenderBuffers != null)
            {
                for (int i = 0; i < m_VelocityRenderBuffers.Length; ++i)
                {
                    cmd.ReleaseTemporaryRT(m_VelocityRenderBuffers[i].id);
                }
                m_VelocityRenderBuffers = null;
            }

            if (m_VelocityNeighborMaxRenderBuffers != null)
            {
                for (int i = 0; i < m_VelocityNeighborMaxRenderBuffers.Length; ++i)
                {
                    cmd.ReleaseTemporaryRT(m_VelocityNeighborMaxRenderBuffers[i].id);
                }
                m_VelocityNeighborMaxRenderBuffers = null;
            }
        }

        public override void FrameCleanup(CommandBuffer cmd)
        {
            this.Cleanup(cmd);
        }
    }

}