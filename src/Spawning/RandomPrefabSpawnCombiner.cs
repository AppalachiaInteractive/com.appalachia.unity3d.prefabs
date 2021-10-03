namespace Appalachia.Core.Spawning
{
    public static class RandomPrefabSpawnCombiner
    {
        /*public static void CombineAndReset(PrefabSpawnCombineSettings settings)
        {
            var template = prefabs.First();

            var assetPath = AssetDatabase.GetAssetPath(template);
            var folder = Path.GetDirectoryName(assetPath);
            var newName = $"{template.name}_{spawned}_COMBINED";

            var newPrefab = new GameObject(newName);
            newPrefab.transform.position = Vector3.zero;
            newPrefab.transform.rotation = Quaternion.identity;
            newPrefab.transform.localScale = Vector3.one;

            var newPrefabFile = $"{folder}\\{newName}.prefab";

            for (var i = transform.childCount - 1; i >= 0; i--)
            {
                transform.GetChild(i).SetParent(newPrefab.transform, true);
            }

            if (settings.removeRigidbodiesWhileCombining)
            {
                var rigidbodies = newPrefab.GetComponentsInChildren<Rigidbody>();
                for (var i = rigidbodies.Length - 1; i >= 0; i--)
                {
                    Destroy(rigidbodies[i]);
                }
            }

            if (settings.removeCollidersWhileCombining)
            {
                var colliders = newPrefab.GetComponentsInChildren<Collider>();
                for (var i = colliders.Length - 1; i >= 0; i--)
                {
                    Destroy(colliders[i]);
                }
            }

            PrefabUtility.SaveAsPrefabAssetAndConnect(newPrefab, newPrefabFile, InteractionMode.AutomatedAction);

            if (settings.disableAfterCombining)
            {
                newPrefab.SetActive(false);
            }

            spawned = 0;
            prefabSpawnStyle = PrefabSpawnStyle.Disabled;
        }*/
    }
}
