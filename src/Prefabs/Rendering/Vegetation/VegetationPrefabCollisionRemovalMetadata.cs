#region

using Appalachia.Core.Objects.Root;
using Appalachia.Rendering.Prefabs.Rendering.Collections;
using AwesomeTechnologies.Vegetation.PersistentStorage;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Vegetation
{
    public class VegetationPrefabCollisionRemovalMetadata : AppalachiaObject<>
    {
        public AppaList_VegetationPrefabCollisionRemovalInfo collisionInfos = new(24);

        public PersistentVegetationStoragePackage persistentStorage;
    }
}
