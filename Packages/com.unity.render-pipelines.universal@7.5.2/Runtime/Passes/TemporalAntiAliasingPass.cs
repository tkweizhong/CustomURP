//namespace UnityEngine.Rendering.Universal.Internal
//{
//    /// <summary>
//    /// Temporal Anti-Aliasing Pass;
//    /// </summary>
//    public class TemporalAntiAliasingPass : ScriptableRenderPass
//    {
//        const string m_ProfilerTag = "TemporalAntiAliasingPass";
//        RenderTargetHandle m_Source;
//        RenderTargetHandle m_Destination;
//        RenderTargetHandle m_PreviousDestination;
//        Material m_Material;

//        private Matrix4x4 m_ModleViewProjetor = Matrix4x4.identity;

//        const int k_HaltonSequenceCount = 20;
//        Vector4 m_Jitter = new Vector4(0, 0, 0, 0);
//        float[,] m_HaltonSequence = new float[k_HaltonSequenceCount, 2] {
//            {-0.2314453f,-0.067444f},
//            {0.2685547f,0.2658893f},
//            {-0.3564453f,-0.2896662f},
//            {0.1435547f,0.04366708f},
//            {-0.1064453f,0.3770005f},
//            {0.3935547f,-0.1785551f},
//            {-0.4189453f,0.1547782f},
//            {0.08105469f,0.4881116f},
//            {-0.1689453f,-0.4954275f},
//            {0.3310547f,-0.1620942f},
//            {-0.2939453f,0.1712391f},
//            {0.2060547f,-0.3843164f},
//            {-0.04394531f,-0.05098307f},
//            {0.4560547f,0.2823502f},
//            {-0.4501953f,-0.2732053f},
//            {0.04980469f,0.06012803f},
//            {-0.2001953f,0.3934613f},
//            {0.2998047f,-0.4583905f},
//            {-0.3251953f,-0.1250571f},
//            {0.1748047f,0.2082762f},
//        };

//        public TemporalAntiAliasingPass(RenderPassEvent evt, Material blitMaterial)
//        {
//            m_Material = blitMaterial;
//            renderPassEvent = evt;
//        }

//        /// <summary>
//        /// Configure the pass;
//        /// </summary>
//        /// <param name="colorHandle"></param>
//        /// <param name="destinationHandle"></param>
//        public void Setup(RenderTargetHandle sourceHandle, RenderTargetHandle destinationHandle, 
//            RenderTargetHandle previousHandle)
//        {
//            m_Source = sourceHandle;
//            m_Destination = destinationHandle;
//            m_PreviousDestination = previousHandle;
//        }

//        /// <summary>
//        /// Gets a jittered perspective projection matrix for a given camera.
//        /// </summary>
//        /// <param name="camera">The camera to build the projection matrix for</param>
//        /// <param name="offset">The jitter offset</param>
//        /// <returns>A jittered projection matrix</returns>
//        public static Matrix4x4 GetJitteredPerspectiveProjectionMatrix(Camera camera, Vector2 offset)
//        {
//            float near = camera.nearClipPlane;
//            float far = camera.farClipPlane;

//            float vertical = Mathf.Tan(0.5f * Mathf.Deg2Rad * camera.fieldOfView) * near;
//            float horizontal = vertical * camera.aspect;

//            offset.x *= horizontal / (0.5f * camera.pixelWidth);
//            offset.y *= vertical / (0.5f * camera.pixelHeight);

//            var matrix = camera.projectionMatrix;

//            matrix[0, 2] += offset.x / horizontal;
//            matrix[1, 2] += offset.y / vertical;

//            return matrix;
//        }

//        /// <inheritdoc/>
//        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
//        {
//            if (m_Material == null)
//            {
//                Debug.LogErrorFormat("Missing {0}. {1} render pass will not execute. Check for missing reference in the renderer resources.", m_Material, GetType().Name);
//                return;
//            }
            
//            ref CameraData cameraData = ref renderingData.cameraData;

//            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
            
//            Material material = m_Material;
//            cmd.SetGlobalTexture("_CurrentTex", m_Source.Identifier());
//            cmd.SetGlobalTexture("_HistoryTex", m_PreviousDestination.Identifier());
//            cmd.SetGlobalInt("gFrameCount", Time.frameCount);

//            int index = Time.frameCount % k_HaltonSequenceCount;
//            m_Jitter.x = m_HaltonSequence[index, 0];
//            m_Jitter.y = m_HaltonSequence[index, 1];
//            cmd.SetGlobalVector("gJitter", m_Jitter);

//            {
//                SetRenderTarget(
//                    cmd,
//                    m_Destination.Identifier(),
//                    RenderBufferLoadAction.Load,
//                    RenderBufferStoreAction.Store,
//                    ClearFlag.None,
//                    Color.black, TextureDimension.Tex2D);

//                Camera camera = cameraData.camera;
//                cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
//                cmd.SetViewport(cameraData.pixelRect);
//                cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, material);
//                cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
//            }

//            context.ExecuteCommandBuffer(cmd);
//            CommandBufferPool.Release(cmd);
//        }
//    }
//}
