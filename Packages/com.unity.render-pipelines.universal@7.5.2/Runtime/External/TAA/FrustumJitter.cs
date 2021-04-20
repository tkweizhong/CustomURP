
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace TAANS
{

    public class CameraJitterPass : ScriptableRenderPass
    {
        const string m_ProfilerTag = "CameraJItterPass";
        private ProfilingSampler m_ProfilingSampler;

        private TAAData m_TAAData;

        public CameraJitterPass(RenderPassEvent evt)
        {
            this.renderPassEvent = evt;
        }

        public void Setup(TAAData data)
        {
            m_TAAData = data;
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);

            using (new ProfilingScope(cmd, m_ProfilingSampler))
            {
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
                Camera camera = renderingData.cameraData.camera;
                cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, m_TAAData.jitteredProjectionMatrix);
            }

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }
}