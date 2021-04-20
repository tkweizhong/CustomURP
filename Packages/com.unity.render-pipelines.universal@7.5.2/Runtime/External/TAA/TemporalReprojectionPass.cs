using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Experimental.Rendering;

namespace TAANS
{
    public class TemporalReprojectionPass : ScriptableRenderPass
    {
        const string m_ProfilerTag = "TemporalReprojectionPass";
        private bool m_IsCameraStereo = false;
        private bool m_FirstTimeExcute = true;
        private TAAData m_TAAData;

        //Note: store previous color buffer & store current color buffer.
        private static RenderTargetIdentifier[] renderTargetsIndentifier = new RenderTargetIdentifier[2];

        public Shader reprojectionShader;
        private Material reprojectionMaterial;
        private RenderTexture[] reprojectionTexture;
        private bool m_Visible = false;
        private int m_Destination = -1;
        private int m_Source = -1;

        public enum Neighborhood
        {
            MinMax3x3,
            MinMax3x3Rounded,
            MinMax4TapVarying,
        };

        public static Neighborhood neighborhood = Neighborhood.MinMax3x3Rounded;
        public static bool unjitterColorSamples = false;
        public static bool unjitterNeighborhood = false;
        public static bool unjitterReprojection = true;
        public static bool useYCoCg = true;
        public static bool useClipping = true;
        public static bool useDilation = true;
        public static bool useMotionBlur = true;
        public static bool useOptimizations = true;

        [Range(0.0f, 1.0f)] public static float feedbackMin = 0.88f;
        [Range(0.0f, 1.0f)] public static float feedbackMax = 0.97f;

        public float motionBlurStrength = 1.0f;
        public bool motionBlurIgnoreFF = false;

        public TemporalReprojectionPass(RenderPassEvent evt)
        {
            this.renderPassEvent = evt;

            m_Visible = false;
            m_FirstTimeExcute = true;

            reprojectionShader = Shader.Find("Hidden/Universal Render Pipeline/TemporalReprojection");
            EnsureInstance.EnsureMaterial(ref reprojectionMaterial, reprojectionShader);
        }

        public void Setup(TAAData data)
        {
            m_TAAData = data;
        }

        public void Setup(int source, int destination)
        {
            m_Source = source;
            m_Destination = destination;
        }

        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
        {
            int targetArraySize = m_IsCameraStereo ? 2 : 1;
            bool needCreateRenderBuffers = reprojectionTexture == null;
            if (reprojectionTexture != null && reprojectionTexture.Length != targetArraySize)
                needCreateRenderBuffers = true;

            if (needCreateRenderBuffers)
            {
                if (reprojectionTexture != null)
                {
                    for (int i = 0, n = (reprojectionTexture.Length); i < n; ++i)
                    {
                        DestroyTexture(reprojectionTexture[i]);
                    }
                }

                reprojectionTexture = new RenderTexture[targetArraySize];

                RenderTextureDescriptor descriptor = cameraTextureDescriptor;
                descriptor.graphicsFormat = GraphicsFormat.B10G11R11_UFloatPack32;
                descriptor.msaaSamples = 1;
                descriptor.depthBufferBits = 0;

                for (int i = 0; i < targetArraySize; ++i)
                {
                    reprojectionTexture[i] = new RenderTexture(descriptor);
                    reprojectionTexture[i].name = string.Format("reprojectionBuffer_{0}0", i);
                }
            }
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData data)
        {
            if (reprojectionMaterial == null)
            {
                Debug.LogError(string.Format("TemporalReprojectionPass reprojectionMaterial is null"));
                return;
            }

            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
            ref CameraData cameraData = ref data.cameraData;
            Camera camera = cameraData.camera;

#if SUPPORT_STEREO
        int eyeIndex = (camera.stereoActiveEye == Camera.MonoOrStereoscopicEye.Right) ? 1 : 0;
#else
            int eyeIndex = 0;
#endif

#if UNITY_EDITOR
            bool allowMotionBlur = !m_IsCameraStereo && Application.isPlaying;
#else
        bool allowMotionBlur = !m_IsCameraStereo;
#endif

            EnsureInstance.EnsureKeyword(reprojectionMaterial, "CAMERA_PERSPECTIVE", !camera.orthographic);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "CAMERA_ORTHOGRAPHIC", camera.orthographic);

            EnsureInstance.EnsureKeyword(reprojectionMaterial, "MINMAX_3X3", neighborhood == Neighborhood.MinMax3x3);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "MINMAX_3X3_ROUNDED", neighborhood == Neighborhood.MinMax3x3Rounded);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "MINMAX_4TAP_VARYING", neighborhood == Neighborhood.MinMax4TapVarying);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "UNJITTER_COLORSAMPLES", unjitterColorSamples);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "UNJITTER_NEIGHBORHOOD", unjitterNeighborhood);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "UNJITTER_REPROJECTION", unjitterReprojection);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "USE_YCOCG", useYCoCg);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "USE_CLIPPING", useClipping);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "USE_DILATION", useDilation);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "USE_MOTION_BLUR", useMotionBlur && allowMotionBlur);

            EnsureInstance.EnsureKeyword(reprojectionMaterial, "USE_MOTION_BLUR_NEIGHBORMAX",
                m_TAAData.neighborMaxGen);
            EnsureInstance.EnsureKeyword(reprojectionMaterial, "USE_OPTIMIZATIONS", useOptimizations);
            reprojectionMaterial.SetInt("_FirstTimeExcute", m_FirstTimeExcute ? 1 : 0);
            m_FirstTimeExcute = false;

            Vector4 jitterUV = m_TAAData.offset;
            jitterUV.x /= cameraData.pixelWidth;
            jitterUV.y /= cameraData.pixelHeight;
            jitterUV.z /= cameraData.pixelWidth;
            jitterUV.w /= cameraData.pixelHeight;

            reprojectionMaterial.SetVector("_JitterUV", jitterUV);

            //cmd.SetGlobalTexture("_VelocityBuffer", m_VelocityBufferPass.activeVelocityRenderBuffer.id);
            //if (m_TAAData.neighborMaxGen)
            //{
            //    cmd.SetGlobalTexture("_VelocityNeighborMax",
            //        m_VelocityBufferPass.activeVelocityNeighborMaxRenderBuffer.id);
            //}
            cmd.SetGlobalVector("_CameraDepthTexture_TexelSize",
                new Vector4(cameraData.cameraTargetDescriptor.width, cameraData.cameraTargetDescriptor.height, 0, 0));

            reprojectionMaterial.SetVector("_CurrentTex_TexelSize",
                new Vector4(cameraData.cameraTargetDescriptor.width, cameraData.cameraTargetDescriptor.height, 0, 0));
            cmd.SetGlobalTexture("_CurrentTex", new RenderTargetIdentifier(m_Source));
            reprojectionMaterial.SetTexture("_PrevTex", reprojectionTexture[eyeIndex]);
            reprojectionMaterial.SetFloat("_FeedbackMin", feedbackMin);
            reprojectionMaterial.SetFloat("_FeedbackMax", feedbackMax);
            //reprojectionMaterial.SetFloat("_MotionScale", motionBlurStrength * (motionBlurIgnoreFF ? Mathf.Min(1.0f, 1.0f / m_VelocityBufferPass.timeScale) : 1.0f));

            // re-project frame n-1 into output + history buffer.
            {
                RenderTargetHandle tempRenderTargetHandle = new RenderTargetHandle();
                tempRenderTargetHandle.Init("_TempReprojectionBuffer");
                RenderTextureDescriptor descriptor = cameraData.cameraTargetDescriptor;
                descriptor.msaaSamples = 1;
                descriptor.depthBufferBits = 0;
                cmd.GetTemporaryRT(tempRenderTargetHandle.id, descriptor);

                renderTargetsIndentifier[0] = m_Destination;
                renderTargetsIndentifier[1] = tempRenderTargetHandle.id;

                cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
                cmd.SetViewport(cameraData.pixelRect);
                reprojectionMaterial.SetPass(0);
                cmd.SetRenderTarget(renderTargetsIndentifier, tempRenderTargetHandle.id, 0, CubemapFace.Unknown, -1);

                cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, reprojectionMaterial, 0, 0);
                cmd.Blit(tempRenderTargetHandle.Identifier(), reprojectionTexture[eyeIndex].colorBuffer);

                cmd.ReleaseTemporaryRT(tempRenderTargetHandle.id);
                cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
            }

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }

        private void DestroyTexture(RenderTexture renderTexture)
        {
            if (renderTexture == null)
                return;
#if UNITY_EDITOR
            GameObject.DestroyImmediate(renderTexture);
#else
        GameObject.Destroy(renderTexture);
#endif
            renderTexture = null;
        }

        public override void FrameCleanup(CommandBuffer cmd)
        {
        }

        public void ForceClenupAll(CommandBuffer cmd)
        {
            m_FirstTimeExcute = true;
            if (reprojectionTexture != null)
            {
                for (int i = 0, n = reprojectionTexture.Length; i < n; ++i)
                {
                    DestroyTexture(reprojectionTexture[i]);
                }
                reprojectionTexture = null;
            }
        }
    }
}