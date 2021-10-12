#region

using System;
using Appalachia.Core.Attributes;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Appalachia.Utility.Enums;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    [AlwaysInitializeOnLoad]
    public class PrefabContentTypeOptionsLookup : PrefabTypeOptionsLookup<PrefabContentType,
        PrefabContentTypeOptions, PrefabContentTypeOptionsOverride, PrefabContentTypeOptionsSetData,
        PrefabContentTypeOptionsWrapper, PrefabContentTypeOptionsLookup,
        Index_PrefabContentTypeOptions, PrefabContentTypeOptionsToggle,
        Index_PrefabContentTypeOptionsToggle, AppaList_PrefabContentType,
        AppaList_PrefabContentTypeOptionsWrapper, AppaList_PrefabContentTypeOptionsToggle>
    {
        private const string _PRF_PFX = nameof(PrefabContentTypeOptionsLookup) + ".";

        static PrefabContentTypeOptionsLookup()
        {
            _types = new EnumValuesCollection<PrefabContentType>(PrefabContentType.None);
        }

        protected override bool _anySoloed => PrefabContentTypeOptions.AnySolo;

        protected override bool _anyMuted => PrefabContentTypeOptions.AnyMute;

        protected override void InitializeState()
        {
            for (var i = 0; i < _types.Length; i++)
            {
                var value = _types.Values[i];

                if (!_state.ContainsKey(value) ||
                    (_state[value] == null) ||
                    (_state[value].type == PrefabContentType.None) ||
                    (_state[value].options == default))
                {
                    var options = PrefabContentTypeOptionsWrapper.LoadOrCreateNew(value.ToString());

                    options.type = value;

                    switch (value)
                    {
                        case PrefabContentType.Fungus:
                            break;
                        case PrefabContentType.Flowers:
                            break;
                        case PrefabContentType.Fern:
                            break;
                        case PrefabContentType.Grass:
                            break;
                        case PrefabContentType.GroundCover:
                            break;
                        case PrefabContentType.Plant:
                            break;
                        case PrefabContentType.Crop:
                            break;
                        case PrefabContentType.Corn:
                            break;
                        case PrefabContentType.AquaticPlant:
                            break;
                        case PrefabContentType.Boulder:
                            break;
                        case PrefabContentType.Gravel:
                            break;
                        case PrefabContentType.Stone:
                            break;
                        case PrefabContentType.Log:
                            break;
                        case PrefabContentType.Branch:
                            break;
                        case PrefabContentType.Stump:
                            break;
                        case PrefabContentType.Tree:
                            break;
                        case PrefabContentType.Leaves:
                            break;
                        case PrefabContentType.Trunk:
                            break;
                        case PrefabContentType.Hillside:
                            break;
                        case PrefabContentType.Ridge:
                            break;
                        case PrefabContentType.Cliff:
                            break;
                        case PrefabContentType.Roots:
                            break;
                        default:
                            throw new ArgumentOutOfRangeException();
                    }

                    _state.AddIfKeyNotPresent(value, options);
                }
            }
        }
    }
}
