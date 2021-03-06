#region

using Appalachia.Core.Objects.Scriptables;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Settings
{
    public class PrefabSpawnSettings : IdentifiableAppalachiaObject<PrefabSpawnSettings>
    {
        
        
        [BoxGroup("Timing")]
        [HideLabel]
        [LabelWidth(0)]
        [InlineProperty]
        public PrefabSpawnTimingSettings timing;

        [BoxGroup("Physics")]
        [HideLabel]
        [LabelWidth(0)]
        [InlineProperty]
        public PrefabSpawnPhysicsSettings physics;

        [BoxGroup("Instances")]
        [HideLabel]
        [LabelWidth(0)]
        [InlineProperty]
        public PrefabSpawnInstanceSettings instance;

        [BoxGroup("Combining")]
        [HideLabel]
        [LabelWidth(0)]
        [InlineProperty]
        public PrefabSpawnCombineSettings combine;
    }
}
