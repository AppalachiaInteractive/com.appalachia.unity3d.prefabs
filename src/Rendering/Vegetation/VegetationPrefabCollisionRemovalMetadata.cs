#region

using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Scriptables;
using AwesomeTechnologies.Vegetation.PersistentStorage;

#endregion

namespace Appalachia.Core.Rendering.Vegetation
{
    public class VegetationPrefabCollisionRemovalMetadata : SelfSavingScriptableObject<VegetationPrefabCollisionRemovalMetadata>
    {
        public AppaList_VegetationPrefabCollisionRemovalInfo collisionInfos = new AppaList_VegetationPrefabCollisionRemovalInfo(24);

        public PersistentVegetationStoragePackage persistentStorage;
    }
}
