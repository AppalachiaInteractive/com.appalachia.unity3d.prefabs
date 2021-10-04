#region

using System;
using Appalachia.Base.Scriptables;
using AwesomeTechnologies.VegetationSystem;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering
{
    [Serializable]
    public class
        ExternalRenderingParameters : SelfSavingAndIdentifyingScriptableObject<
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
