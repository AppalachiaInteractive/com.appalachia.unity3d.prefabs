#region

using System;
using Appalachia.Core.Objects.Root;
using Appalachia.Rendering.Prefabs.Core.States;
using Unity.Mathematics;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Data
{
    public class PrefabRenderingSetLocations : AppalachiaObject<PrefabRenderingSetLocations>
    {
        #region Fields and Autoproperties

        [SerializeField] private float4x4[] _locations;

        #endregion

        public float4x4[] locations
        {
            get => _locations;
            set => _locations = value;
        }

        public void SetFromInstance(PrefabRenderingSet set)
        {
            var element = set.instanceManager.element;

            var count = element.Count;

            _locations = new float4x4[count];

            for (var i = 0; i < count; i++)
            {
                var instance = element.instances[i];

                var state = instance.currentState;

                float4x4 matrix;

                switch (state.rendering)
                {
                    case InstanceRenderingState.NotSet:
                        matrix = element.matrices_original[i];
                        break;
                    case InstanceRenderingState.MeshRenderers:
                        matrix = instance.transform.localToWorldMatrix;
                        break;
                    case InstanceRenderingState.GPUInstancing:
                        matrix = element.matrices_noGameObject_OWNED[i];
                        break;
                    case InstanceRenderingState.Disabled:
                        matrix = element.matrices_original[i];
                        break;
                    default:
                        throw new ArgumentOutOfRangeException();
                }

                _locations[i] = matrix;
            }

#if UNITY_EDITOR
            MarkAsModified();
#endif
        }
    }
}
