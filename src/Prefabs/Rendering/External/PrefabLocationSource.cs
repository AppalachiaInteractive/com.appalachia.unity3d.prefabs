#region

using System;
using System.Collections.Generic;
using System.Linq;
using Appalachia.CI.Integration.Assets;
using Appalachia.Core.Scriptables;
using Appalachia.Utility.Logging;
using AwesomeTechnologies.Vegetation.PersistentStorage;
using AwesomeTechnologies.VegetationSystem;
using Unity.Collections;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;

#endregion

#if UNITY_EDITOR

#endif

namespace Appalachia.Rendering.Prefabs.Rendering.External
{
    [Serializable]
    public class PrefabLocationSource : SingletonAppalachiaObject<PrefabLocationSource>
    {
        private const string _PRF_PFX = nameof(PrefabLocationSource) + ".";

        private static readonly ProfilerMarker _PRF_GetRenderingParameters =
            new(_PRF_PFX + nameof(GetRenderingParameters));

        private static readonly ProfilerMarker _PRF_GetRenderingParametersFromVegetationStudio =
            new(_PRF_PFX + nameof(GetRenderingParametersFromVegetationStudio));

        private static readonly ProfilerMarker _PRF_CreateParametersForPrefab =
            new(_PRF_PFX + nameof(CreateParametersForPrefab));

        private static readonly ProfilerMarker _PRF_InitializeVegetationItemIndexLookup =
            new(_PRF_PFX + nameof(InitializeVegetationItemIndexLookup));

        private static readonly ProfilerMarker _PRF_UpdateRuntimeRenderingParameters =
            new(_PRF_PFX + nameof(UpdateRuntimeRenderingParameters));

        private static readonly ProfilerMarker _PRF_GetMatricesFromVegetationSystem =
            new(_PRF_PFX + nameof(GetMatricesFromVegetationSystem));

        private static readonly ProfilerMarker _PRF_GetTRSFromVegetationStorage =
            new(_PRF_PFX + nameof(GetTRSFromVegetationStorage));

        public List<PersistentVegetationStoragePackage> storagePackages;

        public bool sourceFromActiveVegetationSystems = true;
        [NonSerialized] private Dictionary<string, int> _itemIndices;
        [NonSerialized] private Dictionary<string, int> _packageIndices;

        [NonSerialized] private VegetationSystemPro _veggieSystem;

        private VegetationSystemPro veggieSystem
        {
            get
            {
                if (_veggieSystem == null)
                {
                    _veggieSystem = FindObjectOfType<VegetationSystemPro>();
                }

                return _veggieSystem;
            }
        }

        public List<ExternalRenderingParameters> GetRenderingParameters(
            Dictionary<string, ExternalRenderingParameters> existing)
        {
            using (_PRF_GetRenderingParameters.Auto())
            {
                InitializeVegetationItemIndexLookup();

                GetRenderingParametersFromVegetationStudio(existing);

                ExternalRenderingParameters.UpdateAllIDs();

                return existing.Values.ToList();
            }
        }

        private void GetRenderingParametersFromVegetationStudio(
            Dictionary<string, ExternalRenderingParameters> prefabs)
        {
            using (_PRF_GetRenderingParametersFromVegetationStudio.Auto())
            {
                if (sourceFromActiveVegetationSystems)
                {
                    for (var packageIndex = 0;
                        packageIndex < veggieSystem.VegetationPackageProList.Count;
                        packageIndex++)
                    {
                        var package = veggieSystem.VegetationPackageProList[packageIndex];
                        for (var infoIndex = 0;
                            infoIndex < package.VegetationInfoList.Count;
                            infoIndex++)
                        {
                            var info = package.VegetationInfoList[infoIndex];

                            if (info.TestOnly)
                            {
                                continue;
                            }

                            var prefab = info.VegetationPrefab;

                            var labels = AssetDatabaseManager.GetLabels(prefab);

                            if (labels.Length == 0)
                            {
                               AppaLog.Warning(
                                    $"No labels for asset [{prefab.name}]. Setting it as a test prefab."
                                );
                                info.TestOnly = true;
                                continue;
                            }

                            CreateParametersForPrefab(
                                prefabs,
                                $"{info.Name}_{info.VegetationItemID}",
                                inst => inst.SetVegetationItemInfoPro(info)
                            );
                        }
                    }
                }

                if (storagePackages == null)
                {
                    storagePackages = new List<PersistentVegetationStoragePackage>();
                }

                for (var storagePackageIndex = 0;
                    storagePackageIndex < storagePackages.Count;
                    storagePackageIndex++)
                {
                    var storagePackage = storagePackages[storagePackageIndex];
                    for (var storageCellIndex = 0;
                        storageCellIndex < storagePackage.PersistentVegetationCellList.Count;
                        storageCellIndex++)
                    {
                        var cell = storagePackage.PersistentVegetationCellList[storageCellIndex];
                        for (var storageItemIndex = 0;
                            storageItemIndex < cell.PersistentVegetationInfoList.Count;
                            storageItemIndex++)
                        {
                            var storageItem = cell.PersistentVegetationInfoList[storageItemIndex];

                            if (_packageIndices.TryGetValue(
                                storageItem.VegetationItemID,
                                out var packageIndex
                            ))
                            {
                                var itemIndex = _itemIndices[storageItem.VegetationItemID];

                                var info = _veggieSystem.VegetationPackageProList[packageIndex]
                                                        .VegetationInfoList[itemIndex];

                                if (info != null)
                                {
                                    if (info.TestOnly)
                                    {
                                        continue;
                                    }

                                    CreateParametersForPrefab(
                                        prefabs,
                                        $"{info.Name}_{storageItem.VegetationItemID}_STORAGE",
                                        inst => inst.SetVegetationItemInfoPro(info)
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }

        private void CreateParametersForPrefab(
            Dictionary<string, ExternalRenderingParameters> prefabs,
            string identifyingKey,
            Action<ExternalRenderingParameters> update)
        {
            using (_PRF_CreateParametersForPrefab.Auto())
            {
                ExternalRenderingParameters erp;

                if (!prefabs.ContainsKey(identifyingKey))
                {
                    erp = ExternalRenderingParameters.LoadOrCreateNew(
                        identifyingKey,
                        true,
                        false
                    );

                    prefabs.Add(identifyingKey, erp);
                }
                else
                {
                    erp = prefabs[identifyingKey];
                }

                update(erp);

                erp.identifyingKey = identifyingKey;

                erp.SetDirty();
            }
        }

        private void InitializeVegetationItemIndexLookup()
        {
            using (_PRF_InitializeVegetationItemIndexLookup.Auto())
            {
                if (_packageIndices == null)
                {
                    _packageIndices = new Dictionary<string, int>();
                }
                else
                {
                    _packageIndices.Clear();
                }

                if (_itemIndices == null)
                {
                    _itemIndices = new Dictionary<string, int>();
                }
                else
                {
                    _itemIndices.Clear();
                }

                for (var i = 0; i < veggieSystem.VegetationPackageProList.Count; i++)
                {
                    var package = veggieSystem.VegetationPackageProList[i];

                    for (var j = 0; j < package.VegetationInfoList.Count; j++)
                    {
                        var info = package.VegetationInfoList[j];

                        _itemIndices.Add(info.VegetationItemID, j);
                        _packageIndices.Add(info.VegetationItemID, i);
                    }
                }
            }
        }

        public void UpdateRuntimeRenderingParameters(
            ExternalRenderingParameters parameters,
            out int packageIndex,
            out int itemIndex,
            out VegetationItemInfoPro veggie)
        {
            using (_PRF_UpdateRuntimeRenderingParameters.Auto())
            {
                if (_packageIndices.TryGetValue(parameters.vegetationItemID, out packageIndex))
                {
                    itemIndex = _itemIndices[parameters.vegetationItemID];

                    veggie = _veggieSystem.VegetationPackageProList[packageIndex]
                                          .VegetationInfoList[itemIndex];

                    if (veggie != null)
                    {
                        parameters.SetVegetationItemInfoPro(veggie);
                    }
                }
                else
                {
                    veggie = null;
                    packageIndex = -1;
                    itemIndex = -1;
                }
            }
        }

        public void GetMatricesFromVegetationSystem(
            ExternalRenderingParameters parameters,
            int packageIndex,
            int itemIndex,
            NativeList<float4x4> matrices,
            int parameterIndex,
            NativeList<int> parameterIndices)
        {
            using (_PRF_GetMatricesFromVegetationSystem.Auto())
            {
                if (parameters == null)
                {
                    return;
                }

                if (!parameters.enabled)
                {
                    return;
                }

                _veggieSystem.CompleteCellLoading();

                for (var cellIndex = 0;
                    cellIndex < _veggieSystem.VegetationCellList.Count;
                    cellIndex++)
                {
                    var cell = _veggieSystem.VegetationCellList[cellIndex];
                    if (cell.Prepared)
                    {
                        var vegetationInstanceList = cell
                                                    .VegetationPackageInstancesList[packageIndex]
                                                    .VegetationItemMatrixList[itemIndex];

                        for (var instanceIndex = 0;
                            instanceIndex < vegetationInstanceList.Length;
                            instanceIndex++)
                        {
                            var vegetationInstance = vegetationInstanceList[instanceIndex];

                            matrices.Add(vegetationInstance.Matrix);

                            parameterIndices.Add(parameterIndex);
                        }
                    }

                    _veggieSystem.VegetationPackageProList[packageIndex]
                                 .VegetationInfoList[itemIndex]
                                 .EnableRuntimeRendering = false;
                }
            }
        }

        public void GetTRSFromVegetationStorage(
            PersistentVegetationStoragePackage storage,
            ExternalRenderingParameters parameters,
            NativeList<float3> positions,
            NativeList<quaternion> rotations,
            NativeList<float3> scales,
            int parameterIndex,
            NativeList<int> parameterIndices)
        {
            using (_PRF_GetTRSFromVegetationStorage.Auto())
            {
                if (!parameters.enabled)
                {
                    return;
                }

                for (var cellIndex = 0;
                    cellIndex < storage.PersistentVegetationCellList.Count;
                    cellIndex++)
                {
                    var cell = storage.PersistentVegetationCellList[cellIndex];
                    for (var infoIndex = 0;
                        infoIndex < cell.PersistentVegetationInfoList.Count;
                        infoIndex++)
                    {
                        var persistentInfo = cell.PersistentVegetationInfoList[infoIndex];

                        if (parameters.vegetationItemID == persistentInfo.VegetationItemID)
                        {
                            for (var itemIndex = 0;
                                itemIndex < persistentInfo.VegetationItemList.Count;
                                itemIndex++)
                            {
                                var item = persistentInfo.VegetationItemList[itemIndex];

                                positions.Add(item.Position);
                                rotations.Add(item.Rotation);
                                scales.Add(item.Scale);

                                parameterIndices.Add(parameterIndex);
                            }
                        }
                    }
                }
            }
        }
    }
}
