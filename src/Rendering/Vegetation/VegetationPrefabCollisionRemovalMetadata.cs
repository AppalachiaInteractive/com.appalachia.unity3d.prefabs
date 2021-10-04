#region

using Appalachia.Base.Scriptables;
using Appalachia.Prefabs.Rendering.Collections;
using AwesomeTechnologies.Vegetation.PersistentStorage;

#endregion

namespace Appalachia.Prefabs.Rendering.Vegetation
{
    public class
        VegetationPrefabCollisionRemovalMetadata : SelfSavingScriptableObject<
            VegetationPrefabCollisionRemovalMetadata>
    {
        public AppaList_VegetationPrefabCollisionRemovalInfo collisionInfos = new(24);

        public PersistentVegetationStoragePackage persistentStorage;
    }
}
