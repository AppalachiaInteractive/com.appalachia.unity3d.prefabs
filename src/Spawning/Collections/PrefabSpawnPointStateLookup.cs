#region

using System;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Spawning.Data;
using Appalachia.Spatial.SpatialKeys;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lookups
{
    [Serializable]
    [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 5)]
    public class PrefabSpawnPointStateLookup : AppaLookup<Vector3Key, PrefabSpawnPointState, AppaList_Vector3Key,
        AppaList_PrefabSpawnPointState>
    {
        protected override string GetDisplayTitle(Vector3Key key, PrefabSpawnPointState value)
        {
            throw new NotImplementedException();
        }

        protected override string GetDisplaySubtitle(Vector3Key key, PrefabSpawnPointState value)
        {
            throw new NotImplementedException();
        }

        protected override Color GetDisplayColor(Vector3Key key, PrefabSpawnPointState value)
        {
            throw new NotImplementedException();
        }
    }
}
