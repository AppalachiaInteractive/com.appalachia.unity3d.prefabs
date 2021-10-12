#region

using Appalachia.Core.Scriptables;
using Appalachia.Rendering.Prefabs.Rendering.Collections;
using AwesomeTechnologies.Vegetation.PersistentStorage;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Vegetation
{
    public class
        VegetationPrefabCollisionRemovalMetadata : SelfSavingScriptableObject<
            VegetationPrefabCollisionRemovalMetadata>
    {
        public AppaList_VegetationPrefabCollisionRemovalInfo collisionInfos = new(24);

        public PersistentVegetationStoragePackage persistentStorage;
    }
}
