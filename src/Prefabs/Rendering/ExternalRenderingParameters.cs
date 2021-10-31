#region

using System;
using Appalachia.Core.Scriptables;
using AwesomeTechnologies.VegetationSystem;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    [Serializable]
    public class
        ExternalRenderingParameters : IdentifiableAppalachiaObject<
            ExternalRenderingParameters>
    {
        [HideInInspector] public string identifyingKey;

        [HideInInspector] public string vegetationItemID;

        [HideInInspector] public GameObject prefab;

        [HideInInspector] public bool enabled = true;

        [HideInInspector] public VegetationItemInfoPro veggie;

        public void SetVegetationItemInfoPro(VegetationItemInfoPro v)
        {
            veggie = v;
            identifyingKey = veggie.VegetationItemID;
            prefab = veggie.VegetationPrefab;
            vegetationItemID = veggie.VegetationItemID;
            enabled = veggie.EnableRuntimeSpawn && veggie.EnableExternalRendering;
        }
    }
}
