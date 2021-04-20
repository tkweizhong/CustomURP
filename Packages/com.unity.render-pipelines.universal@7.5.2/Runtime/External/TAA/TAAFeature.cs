using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using Debug = UnityEngine.Debug;

namespace TAANS
{
    public sealed class TAAFeature : ScriptableRendererFeature
    {
        const string m_ProfilerTag = "TAA Pass";

        private  Dictionary<Camera, TAAData>  m_TAADatas;
        private CameraJitterPass m_CameraJitterPass;

        private VelocityRenderBuffersPass m_VelocityPass;
        private TemporalReprojectionPass m_TemporalReprojectionPass;

        private Matrix4x4 m_PrevViewMatrix = Matrix4x4.identity;
        private Matrix4x4 m_PrevProjectionMatrix = Matrix4x4.identity;

        public TAAFeature()
        {
            m_TAADatas = new Dictionary<Camera, TAAData>();
            m_CameraJitterPass = new CameraJitterPass(RenderPassEvent.BeforeRenderingOpaques);
            m_VelocityPass = new VelocityRenderBuffersPass(RenderPassEvent.BeforeRenderingOpaques + 1);
            m_TemporalReprojectionPass = new TemporalReprojectionPass(RenderPassEvent.BeforeRenderingPostProcessing);
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            Camera camera = renderingData.cameraData.camera;
            if (!m_TAADatas.ContainsKey(camera))
            {
                m_TAADatas.Add( camera, new TAAData());
            }

            TAAData data = m_TAADatas[camera];
            var stack = VolumeManager.instance.stack;
            TemporalAntiAliasing temporalAntiAliasing = stack.GetComponent<TemporalAntiAliasing>();
            if (temporalAntiAliasing == null)
            {
#if UNITY_EDITOR
                Debug.LogWarning("Need add TemporalAntiAliasing component");
#endif
            }
            UpdateCameraInfos(ref renderingData, data, temporalAntiAliasing);

            m_CameraJitterPass.Setup(data);
            m_VelocityPass.Setup(data);
            m_TemporalReprojectionPass.Setup(data);
        }

        private void UpdateCameraInfos(ref RenderingData renderingData, TAAData data, TemporalAntiAliasing temporalAntiAliasing)
        {
            Camera camera = renderingData.cameraData.camera;
            data.prevViewMatrix = m_PrevViewMatrix;
            data.prevProjectionMatrix = m_PrevProjectionMatrix;
            Vector2 offset = Utils.Sample();
            data.jitteredProjectionMatrix = camera.orthographic ?
                Utils.GetJitteredOrthographicProjectionMatrix(camera, offset) :
                Utils.GetJitteredPerspectiveProjectionMatrix(camera, offset);

            m_PrevViewMatrix = camera.worldToCameraMatrix;
            m_PrevProjectionMatrix = camera.projectionMatrix;
        }

        public override void Create()
        {
            name = m_ProfilerTag;
        }
    }
}
