#region

using System;
using System.Collections.Generic;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Utility.Enums;
using Unity.Profiling;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [Serializable]
    public abstract class PrefabTypeCounts<TE>
        where TE : Enum
    {
        private const string _PRF_PFX = nameof(PrefabTypeCounts<TE>) + ".";

        protected static readonly EnumValuesCollection<TE> _enumValues = new(false);

        protected Dictionary<TE, int> _typeCounts;
        protected Dictionary<TE, InstanceStateCounts> _typeInstanceCounts;

        private int _typeSum;

        private void InitializeCollectionsIfNull()
        {
            using (_PRF_InitializeCollectionsIfNull.Auto())
            {
                if (_typeCounts == null)
                {
                    _typeCounts = new Dictionary<TE, int>();
                }

                if (_typeInstanceCounts == null)
                {
                    _typeInstanceCounts = new Dictionary<TE, InstanceStateCounts>();
                }
            }
        }

        public void ResetRuntimeCountCollections()
        {
            using (_PRF_ResetRuntimeCountCollections.Auto())
            {
                InitializeCollectionsIfNull();

                for (var index = 0; index < _enumValues.Values.Length; index++)
                {
                    var value = _enumValues.Values[index];
                    if (_typeCounts.ContainsKey(value))
                    {
                        _typeCounts[value] = 0;
                    }

                    if (_typeInstanceCounts.ContainsKey(value))
                    {
                        _typeInstanceCounts[value] = default;
                    }
                }

                _typeSum = 0;
            }
        }

        private void UpdatePrefabTypeCounts()
        {
            using (_PRF_PrefabTypeCounts.Auto())
            {
                InitializeCollectionsIfNull();

                var sets = PrefabRenderingSetCollection.instance.Sets;

                if (sets.Count != _typeSum)
                {
                    _typeSum = 0;

                    for (var i = 0; i < sets.Count; i++)
                    {
                        _typeSum += 1;

                        var item = sets.at[i];
                        var itemType = FromPrefabSet(item);

                        if (!_typeCounts.ContainsKey(itemType))
                        {
                            _typeCounts.Add(itemType, 0);
                        }

                        if (!_typeInstanceCounts.ContainsKey(itemType))
                        {
                            _typeInstanceCounts.Add(itemType, default);
                        }

                        _typeCounts[itemType] += 1;

                        var counts = item.instanceManager.GetStateCounts();

                        _typeInstanceCounts[itemType].AddFrom(counts);
                    }
                }
            }
        }

        protected abstract TE FromPrefabSet(PrefabRenderingSet set);

        public int GetPrefabTypeCount(TE type)
        {
            using (_PRF_GetPrefabTypeCount.Auto())
            {
                if ((_typeCounts == null) || (_typeCounts.Count == 0))
                {
                    ResetRuntimeCountCollections();
                }

                if (!_typeCounts.ContainsKey(type))
                {
                    _typeCounts.Add(type, 0);
                }

                return _typeCounts[type];
            }
        }

        public InstanceStateCounts GetInstanceCount(TE type)
        {
            using (_PRF_GetInstanceCount.Auto())
            {
                if ((_typeInstanceCounts == null) || (_typeInstanceCounts.Count == 0))
                {
                    ResetRuntimeCountCollections();
                }

                if (!_typeInstanceCounts.ContainsKey(type))
                {
                    _typeInstanceCounts.Add(type, default);
                }

                return _typeInstanceCounts[type];
            }
        }

        public void RefreshRuntimeCounts()
        {
            using (_PRF_RefreshRuntimeCounts.Auto())
            {
                ResetRuntimeCountCollections();
                UpdatePrefabTypeCounts();
            }
        }

#region ProfilerMarkers

        private static readonly ProfilerMarker _PRF_InitializeCollectionsIfNull =
            new(_PRF_PFX + nameof(InitializeCollectionsIfNull));

        private static readonly ProfilerMarker _PRF_ResetRuntimeCountCollections =
            new(_PRF_PFX + nameof(ResetRuntimeCountCollections));

        private static readonly ProfilerMarker _PRF_PrefabTypeCounts =
            new(_PRF_PFX + nameof(UpdatePrefabTypeCounts));

        private static readonly ProfilerMarker _PRF_GetPrefabTypeCount =
            new(_PRF_PFX + nameof(GetPrefabTypeCount));

        private static readonly ProfilerMarker _PRF_GetInstanceCount =
            new(_PRF_PFX + nameof(GetInstanceCount));

        private static readonly ProfilerMarker _PRF_RefreshRuntimeCounts =
            new(_PRF_PFX + nameof(RefreshRuntimeCounts));

#endregion
    }
}
