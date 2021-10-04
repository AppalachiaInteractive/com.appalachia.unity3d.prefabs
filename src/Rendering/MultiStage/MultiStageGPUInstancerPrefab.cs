#region

using System;
using Appalachia.Prefabs.Rendering.Runtime;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.MultiStage
{
    public abstract class MultiStageGPUInstancerPrefab<T> : MonoBehaviour
        where T : Enum
    {
        public MultiStagePrefabType prefabType;

        public T currentStages;

        public bool tree => prefabType == MultiStagePrefabType.Tree;

        protected abstract PrefabRenderingInstance GetInstanceForStage(T stage);

        protected abstract bool CanEnableStage(T stage);

        protected bool HasStage(T stage)
        {
            return currentStages.HasFlag(stage);
        }

        /*
        protected void SetStage(RuntimePrefabRenderingDataElement element, PrefabRenderingInstanceData stageData, T stage, bool enableStage)
        {
            stageData.forcedPendingState = enableStage ? GPUInstancingState.None : GPUInstancingState.Disabled;

            if (enableStage && !currentStages.HasFlag(stage))
            {
                SetFlag(stage);
            }
            else if (!enableStage && currentStages.HasFlag(stage))
            {
                ClearFlag(stage);
            }
        }
        */

        protected abstract void SetFlag(T stage);
        protected abstract void ClearFlag(T stage);

        /*
        protected void EnableStage(RuntimePrefabRenderingDataElement element, T stage)
        {
            if (!CanEnableStage(stage))
            {
                return;
            }

            var instance = GetInstanceForStage(stage);

            if (instance == null)
            {
                return;
            }

            SetStage(instance, stage, true);
        }
        */

        /*
        protected void EnableStages(RuntimePrefabRenderingDataElement element, params T[] stages)
        {
            for (var stageIndex = 0; stageIndex < stages.Length; stageIndex++)
            {
                var stage = stages[stageIndex];
                EnableStage(stage);
            }
        }*/

        /*protected void DisableStage(RuntimePrefabRenderingDataElement element, T stage)
        {
            if (!HasStage(stage))
            {
                return;
            }

            var instance = GetInstanceForStage(stage);

            if (instance == null)
            {
                return;
            }

            SetStage(instance, stage, false);
        }*/

        /*protected void DisableStages(RuntimePrefabRenderingDataElement element, params T[] stages)
        {
            for (var stageIndex = 0; stageIndex < stages.Length; stageIndex++)
            {
                var stage = stages[stageIndex];
                DisableStage(stage);
            }
        }*/
    }
}
