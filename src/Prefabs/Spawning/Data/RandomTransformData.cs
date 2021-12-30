#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Objects.Root;
using Appalachia.Spatial.Terrains;
using Appalachia.Spatial.Terrains.Utilities;
using Sirenix.OdinInspector;
using UnityEngine;
using Random = UnityEngine.Random;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    [Serializable]
    [InlineProperty]
    [HideLabel]
    [LabelWidth(0)]
    public class RandomTransformData : AppalachiaSimpleBase
    {
        #region Constants and Static Readonly

        private const float MaxScaleComponent = 1.2f;
        private const float MinScaleComponent = .8f;

        #endregion

        // [CallStaticConstructorInEditor] should be added to the class (initsingletonattribute)
        static RandomTransformData()
        {
            TerrainMetadataManager.InstanceAvailable += i => _terrainMetadataManager = i;
        }

        #region Static Fields and Autoproperties

        private static TerrainMetadataManager _terrainMetadataManager;

        #endregion

        #region Fields and Autoproperties

        [Title("Placement")]
        [BoxGroup("Type")]
        [SmartLabel]
        public RandomPrefabSpawnerInitialization type = RandomPrefabSpawnerInitialization.Dropped;

        [ShowIfGroup("Type/" + nameof(_showThrow))]
        [ShowIfGroup("Type/" + nameof(_showDrop))]
        [ShowIfGroup("Type/" + nameof(_showExact))]
        [ShowIfGroup("Type/" + nameof(_showGrounded))]
        [HorizontalGroup("Type/" + nameof(_showDrop) + "/Drop")]
        [InfoBox("Drop Offset", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        public Vector3 dropOffset = new(0f, 10f, 0f);

        [HorizontalGroup("Type/" + nameof(_showThrow) + "/Thrown")]
        [InfoBox("Throw Offset", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        public Vector3 throwOffset = new(0f, 5f, 0f);

        [HorizontalGroup("Type/" + nameof(_showThrow) + "/Thrown")]
        [InfoBox("Throw Force", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [MinMaxSlider(1.0f, 100f, true)]
        public Vector2 throwForce = new(1.0f, 5.0f);

        [HorizontalGroup("Type/" + nameof(_showThrow) + "/Thrown")]
        [InfoBox("Random Throw", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        public bool randomThrowDirection = true;

        [HorizontalGroup("Type/" + nameof(_showThrow) + "/Thrown")]
        [InfoBox("Throw Direction", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [DisableIf(nameof(randomThrowDirection))]
        public Vector3 throwDirection = new(0f, 1f, 0f);

        [HorizontalGroup("Type/" + nameof(_showExact) + "/Exact")]
        [InfoBox("Spawn Offset", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        public Vector3 spawnOffset = new(0f, 0f, 0f);

        [HorizontalGroup("Type/" + nameof(_showGrounded) + "/Grounded")]
        [InfoBox("Enable Burying)", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        public bool enableBurying;

        [BoxGroup("Position")]
        [HorizontalGroup("Position/A")]
        [InfoBox("Random Offset (XZ)", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [PropertyRange(0.0f, 50.0f)]
        public float randomXZOffset = 5.0f;

        [HorizontalGroup("Position/A")]
        [InfoBox("Circular Offset", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        public bool circularOffset = true;

        [BoxGroup("Rotation")]
        [HorizontalGroup("Rotation/A")]
        [InfoBox("Rotation Type", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        public RandomPrefabRotationType rotationType = RandomPrefabRotationType.RotateXYZ;

        [HorizontalGroup("Rotation/A")]
        [InfoBox("Rotation Limit (X)", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [ShowIf(nameof(_showXYZLimit))]
        [MinMaxSlider(-180f, 180f, true)]
        public Vector2 xRotationLimit = new(-180f, 180f);

        [HorizontalGroup("Rotation/A")]
        [InfoBox("Rotation Limit (Y)", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [ShowIf(nameof(_showYLimit))]
        [MinMaxSlider(-180f, 180f, true)]
        public Vector2 yRotationLimit = new(-180f, 180f);

        [HorizontalGroup("Rotation/A")]
        [InfoBox("Rotation Limit (Z)", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [ShowIf(nameof(_showXYZLimit))]
        [MinMaxSlider(-180f, 180f, true)]
        public Vector2 zRotationLimit = new(-180f, 180f);

        [BoxGroup("Scale")]
        [HorizontalGroup("Scale/A")]
        [InfoBox("Use Uniform Scale", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        public bool useUniformScale = true;

        [HorizontalGroup("Scale/A")]
        [InfoBox("Scale Limit", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [ShowIf(nameof(useUniformScale))]
        [MinMaxSlider(.1f, 10f, true)]
        public Vector2 scaleLimit = new(.8f, 1.2f);

        [HorizontalGroup("Scale/A")]
        [InfoBox("Min Scale", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [HideIf(nameof(useUniformScale))]
        public Vector3 minScale = new(MinScaleComponent, MinScaleComponent, MinScaleComponent);

        [HorizontalGroup("Scale/A")]
        [InfoBox("Max Scale", InfoMessageType.None)]
        [LabelWidth(0)]
        [HideLabel]
        [HideIf(nameof(useUniformScale))]
        public Vector3 maxScale = new(MaxScaleComponent, MaxScaleComponent, MaxScaleComponent);

        #endregion

        private bool _showDrop => type == RandomPrefabSpawnerInitialization.Dropped;
        private bool _showExact => type == RandomPrefabSpawnerInitialization.Exact;
        private bool _showGrounded => type == RandomPrefabSpawnerInitialization.Grounded;
        private bool _showThrow => type == RandomPrefabSpawnerInitialization.Thrown;

        private bool _showXYZLimit => rotationType == RandomPrefabRotationType.RotateXYZ;

        private bool _showYLimit =>
            _showXYZLimit ||
            (rotationType == RandomPrefabRotationType.RotateY) ||
            (rotationType == RandomPrefabRotationType.GroundedRotated);

        public Matrix4x4 GetSpawnMatrix(
            Vector3 root,
            out bool addRigidbody,
            out float force,
            out Vector3 direction)
        {
            var position = GetPosition(root, out var terrainData);

            var rotation = GetRotation(position, terrainData);

            var scale = GetScale();

            GetThrowForce(out force, out direction);

            addRigidbody = (type == RandomPrefabSpawnerInitialization.Dropped) ||
                           (type == RandomPrefabSpawnerInitialization.Thrown);

            return Matrix4x4.TRS(position, rotation, scale);
        }

        private Vector3 GetPosition(Vector3 root, out TerrainMetadata terrainData)
        {
            var additiveX = Random.Range(-1.0f, 1.0f);
            var additiveZ = Random.Range(-1.0f, 1.0f);

            Vector3 additive;

            if (circularOffset)
            {
                var additiveMagnitudeX = Random.Range(0.0f, randomXZOffset);
                var additiveMagnitudeZ = Random.Range(0.0f, randomXZOffset);
                var additiveDirection = new Vector3(additiveX, 0.0f, additiveZ).normalized;

                additive.x = additiveDirection.x * additiveMagnitudeX;
                additive.y = 0.0f;
                additive.z = additiveDirection.z * additiveMagnitudeZ;
            }
            else
            {
                additive = new Vector3(additiveX, 0.0f, additiveZ) * randomXZOffset;
            }

            var position = root + additive;

            terrainData = _terrainMetadataManager.GetTerrainAt(position);

            if (terrainData == null)
            {
                terrainData = _terrainMetadataManager.GetTerrainAt(root);
                position = root;
            }

            var terrainHeight = terrainData.GetWorldSpaceHeight(position);

            switch (type)
            {
                case RandomPrefabSpawnerInitialization.Exact:
                    return position + spawnOffset;
                case RandomPrefabSpawnerInitialization.Grounded:
                    position.y = terrainHeight;
                    return position;
                case RandomPrefabSpawnerInitialization.Dropped:
                    position.y = terrainHeight;
                    return position + dropOffset;
                case RandomPrefabSpawnerInitialization.Thrown:
                    position.y = terrainHeight;
                    return position + throwOffset;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private Quaternion GetRotation(Vector3 position, TerrainMetadata terrainData)
        {
            switch (rotationType)
            {
                case RandomPrefabRotationType.NoRotation:
                {
                    return Quaternion.identity;
                }
                case RandomPrefabRotationType.RotateY:
                {
                    return Quaternion.Euler(0.0f, Random.Range(yRotationLimit.x, yRotationLimit.y), 0.0f);
                }
                case RandomPrefabRotationType.RotateXYZ:
                {
                    return Quaternion.Euler(
                        Random.Range(xRotationLimit.x, xRotationLimit.y),
                        Random.Range(yRotationLimit.x, yRotationLimit.y),
                        Random.Range(zRotationLimit.x, zRotationLimit.y)
                    );
                }
                case RandomPrefabRotationType.Grounded:
                case RandomPrefabRotationType.GroundedRotated:
                {
                    var rot = Quaternion.identity;
                    var normal = (Vector3)terrainData.GetTerrainNormal(position);

                    if (normal != Vector3.up)
                    {
                        var terrainRight = Vector3.Cross(normal, Vector3.up);
                        var lookForward = Vector3.Cross(normal,  terrainRight);
                        rot = Quaternion.LookRotation(lookForward, normal);
                    }

                    if (rotationType == RandomPrefabRotationType.GroundedRotated)
                    {
                        rot *= Quaternion.Euler(0, Random.Range(yRotationLimit.x, yRotationLimit.y), 0);
                    }

                    return rot;
                }
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private Vector3 GetScale()
        {
            if (useUniformScale)
            {
                return Vector3.one * Random.Range(scaleLimit.x, scaleLimit.y);
            }

            return new Vector3(
                Random.Range(minScale.x, maxScale.x),
                Random.Range(minScale.y, maxScale.y),
                Random.Range(minScale.z, maxScale.z)
            );
        }

        private void GetThrowForce(out float force, out Vector3 direction)
        {
            if (type != RandomPrefabSpawnerInitialization.Thrown)
            {
                force = 0.0f;
                direction = Vector3.zero;
                return;
            }

            if (randomThrowDirection)
            {
                direction = new Vector3(Random.Range(-1f, 1f), Random.Range(-1f, 1f), Random.Range(-1f, 1f));
                direction = direction.normalized;
            }
            else
            {
                direction = throwDirection.normalized;
            }

            force = Random.Range(throwForce.x, throwForce.y);
        }
    }
}
