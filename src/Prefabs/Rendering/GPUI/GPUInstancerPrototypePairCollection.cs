/*using System.Collections.Generic;
using GPUInstancer;
using Appalachia.Core.Collections;
using Appalachia.Core.Globals.Serialization.ScriptableObjects;
using Appalachia.Core.Profiling;
using UnityEditor;
using UnityEngine;
#if UNITY_EDITOR

#endif

namespace Appalachia.Core.Rendering.Metadata.GPUI
{
    public class GPUInstancerPrototypePairCollection : SelfSavingSingletonScriptableObject<GPUInstancerPrototypePairCollection>
    {
        [SerializeField] private IndexedGPUInstancerPrototypePairList _prototypePairs = new IndexedGPUInstancerPrototypePairList();
    
        public void ConfirmPrototype(GPUInstancerPrototypePair prototypePair)
        {
            //_prototypePairs.AddIfKeyNotPresent(prototypePair.gameObject.prefab.GetAssetGUID(), prototypePair);
            _prototypePairs.AddIfKeyNotPresent(prototypePair.gameObject.prefab.name, prototypePair);
        }

        public GPUInstancerPrototypePair FindOrCreate(GameObject gameObject, GPUInstancerPrefabManager gpui, 
                                                      Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData> prototypeLookup)
        {
           
using (ASPECT.Many(ASPECT.Profile(), ASPECT.Trace()))
            {
                //var assetGUID = gameObject.GetAssetGUID();
                
                //if (_prototypePairs.ContainsKey(assetGUID))
                if (_prototypePairs.ContainsKey(gameObject.name))
                {
                    //var prototypePair = _prototypePairs[assetGUID]; 
                    var prototypePair = _prototypePairs[gameObject.name]; 
                    prototypePair.UpdatePrototypePair(gameObject, gpui, prototypeLookup);
                    return prototypePair;
                }

                var newPrototypePair = GPUInstancerPrototypePair.CreateAndSave(gameObject.name, true, true, false);
                
                newPrototypePair.UpdatePrototypePair(gameObject, gpui, prototypeLookup);

                //_prototypePairs.AddOrUpdate(assetGUID, newPrototypePair);
                _prototypePairs.AddOrUpdate(gameObject.name, newPrototypePair);

                newPrototypePair.SetDirty();
                SetDirty();
                
#if UNITY_EDITOR
                if (!Application.isPlaying)
                {
                    GPUInstancerPrototypePair.UpdateAllIDs();                    
                }

                AssetDatabaseManager.SaveAssetsNextFrame();
#endif
                
                return newPrototypePair;
            }
        }
    }
}*/


