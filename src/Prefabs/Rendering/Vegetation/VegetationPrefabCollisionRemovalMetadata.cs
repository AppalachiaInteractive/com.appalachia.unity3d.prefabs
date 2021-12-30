#region

using Appalachia.Core.Objects.Root;
using Appalachia.Rendering.Prefabs.Rendering.Collections;
using AwesomeTechnologies.Vegetation.PersistentStorage;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Vegetation
{
    public sealed class
        VegetationPrefabCollisionRemovalMetadata : AppalachiaObject<VegetationPrefabCollisionRemovalMetadata>
    {
        #region Fields and Autoproperties

        public AppaList_VegetationPrefabCollisionRemovalInfo collisionInfos = new(24);

        public PersistentVegetationStoragePackage persistentStorage;

        #endregion
    }
}
