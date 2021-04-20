
using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using static TAANS.CameraJitterPass;
using static TAANS.TemporalReprojectionPass;
using static TAANS.Utils;

namespace TAANS
{

    [Serializable, VolumeComponentMenu("Post-processing/TemporalAntiAliasing")]
    public sealed class TemporalAntiAliasing : VolumeComponent, IPostProcessComponent
    {
        public PatternParameter pattern = new PatternParameter(Pattern.Halton_2_3_X8);
        public ClampedFloatParameter patternScale = new ClampedFloatParameter(0.9f, 0, 1f);

        public ClampedFloatParameter feedbackMin = new ClampedFloatParameter(0.88f, 0, 1f);
        public ClampedFloatParameter feedbackMax = new ClampedFloatParameter(0.97f, 0, 1f);

        public bool IsActive()
        {
            return feedbackMin.value > 0 && feedbackMin.value < feedbackMax.value;
        }

        public bool IsTileCompatible()
        {
            return false;
        }
    }

    [Serializable]
    public sealed class PatternParameter : VolumeParameter<Pattern>
    {
        public PatternParameter(Pattern value, bool overrideState = false) : base(value, overrideState)
        { }
    }


    public class TAAData
    {
        public Pattern pattern = Pattern.Halton_2_3_X8;
        public float patternScale = 1.0f;
        public Vector2 offset = Vector2.zero;
        public Matrix4x4 prevViewMatrix;
        public Matrix4x4 prevProjectionMatrix;
        public Matrix4x4 jitteredProjectionMatrix;

        public bool neighborMaxGen = false;
        /*TemproalReprojection Params*/
        public Neighborhood neighborhood = Neighborhood.MinMax3x3Rounded;

        public bool unjitterColorSamples = false;
        public bool unjitterNeighborhood = false;
        public bool unjitterReprojection = true;
        public bool useYCoCg = true;
        public bool useClipping = true;
        public bool useDilation = true;
        public bool useMotionBlur = true;
        public bool useOptimizations = true;

        public float feedbackMin;
        public float feedbackMax = 0.97f;

    }
}