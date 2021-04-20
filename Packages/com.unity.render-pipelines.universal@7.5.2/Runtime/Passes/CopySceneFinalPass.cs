using System;

namespace UnityEngine.Rendering.Universal.Internal
{
    /// <summary>
    /// Copy the scene color target after post process rendering to the destination color buffer
    ///
    /// </summary>
    public class CopySceneFinalPass : ScriptableRenderPass
    {
        const string m_ProfilerTag = "Copy Scene Final Pass";
        Material m_BlitMaterial;

        private RenderTargetHandle m_Source { get; set; }
        private RenderTargetHandle m_Destination;

        private float m_SamplerScale = 1.0f;

        public CopySceneFinalPass(RenderPassEvent evt, Material blitMaterial)
        {
            m_BlitMaterial = blitMaterial;
            renderPassEvent = evt;
        }

        /// <summary>
        /// Configure the pass with the source and destination to execute on.
        /// </summary>
        /// <param name="source">Source Render Target</param>
        /// <param name="destination">Destination Render Target</param>
        public void Setup(RenderTargetHandle source, RenderTargetHandle destination, float samplerScale)
        {
            this.m_Source = source;

            this.m_Destination = destination;

            this.m_SamplerScale = samplerScale;
        }

        public void RefreshSamplerScale(float scale)
        {
            this.m_SamplerScale = scale;
        }

        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescripor)
        {
            RenderTextureDescriptor descriptor = cameraTextureDescripor;
            descriptor.sRGB = false;
            descriptor.width = (int)(descriptor.width * m_SamplerScale);
            descriptor.height = (int)(descriptor.height * m_SamplerScale);
            descriptor.colorFormat = RenderTextureFormat.RGB111110Float;
            descriptor.dimension = TextureDimension.Tex2D;
            descriptor.depthBufferBits = 32;
            descriptor.graphicsFormat = Experimental.Rendering.GraphicsFormat.B10G11R11_UFloatPack32;

            cmd.GetTemporaryRT(m_Destination.id, descriptor, FilterMode.Bilinear);
        }

        /// <inheritdoc/>
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (m_BlitMaterial == null)
            {
                Debug.LogErrorFormat("Missing {0}. {1} render pass will not execute. Check for missing reference in the renderer resources.", m_BlitMaterial, GetType().Name);
                return;
            }

            ref CameraData cameraData = ref renderingData.cameraData;
            int source = m_Source.id;
            int destination = m_Destination.id;

            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
            cmd.EnableShaderKeyword(ShaderKeywordStrings.LinearToSRGBConversion);
            cmd.DisableShaderKeyword("_SRGB_TO_LINEAR_CONVERSION");

            Material blitMaterial = (cameraData.isStereoEnabled) ? null : m_BlitMaterial;
            cmd.SetGlobalTexture("_BlitTex", m_Source.Identifier());
            cmd.Blit(m_Source.Identifier(), /*BlitDstDiscardContent(cmd, m_Destination)*/ m_Destination.Identifier(), blitMaterial);

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }

        //private BuiltinRenderTextureType BlitDstDiscardContent(CommandBuffer cmd, RenderTargetHandle rt)
        //{
        //    cmd.SetRenderTarget(rt.Identifier(),
        //        RenderBufferLoadAction.Load, RenderBufferStoreAction.Store,
        //        RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
        //    return BuiltinRenderTextureType.CurrentActive;
        //}

        //Need cleanup after last camera rendering;
        public void OnLastCameraStackRendering(CommandBuffer cmd)
        {
            if (cmd == null)
            {
                throw new ArgumentNullException("cmd");
            }

            if (m_Destination != RenderTargetHandle.CameraTarget)
            {
                cmd.ReleaseTemporaryRT(m_Destination.id);
                m_Destination = RenderTargetHandle.CameraTarget;
            }
        }
    }
}
