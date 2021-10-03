using Appalachia.Core.AssetMetadata.Options;
using Appalachia.Core.Editing.Attributes;
using Appalachia.Core.Labeling;

namespace Appalachia.Prefabs.Rendering.src.Metadata
{
    [EditorOnlyInitializeOnLoad]
    public static class PrefabLabelInitializer
    {
        static PrefabLabelInitializer()
        {
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.Scatter,             LABELS.LABEL_Scatter);
            
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.VegetationVerySmall, LABELS.LABEL_VegetationVerySmall);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.VegetationSmall,     LABELS.LABEL_VegetationSmall);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.VegetationMedium,    LABELS.LABEL_VegetationMedium);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.VegetationLarge,     LABELS.LABEL_VegetationLarge);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.VegetationVeryLarge, LABELS.LABEL_VegetationVeryLarge);
            
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.TreeSmall,           LABELS.LABEL_TreeSmall);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.TreeMedium,          LABELS.LABEL_TreeMedium);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.TreeLarge,           LABELS.LABEL_TreeLarge);
            
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.ObjectVerySmall,     LABELS.LABEL_ObjectVerySmall);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.ObjectSmall,         LABELS.LABEL_ObjectSmall);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.ObjectMedium,        LABELS.LABEL_ObjectMedium);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.ObjectLarge,         LABELS.LABEL_ObjectLarge);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.ObjectHuge,          LABELS.LABEL_ObjectHuge);
            
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.AssemblySmall,       LABELS.LABEL_AssemblySmall);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.AssemblyMedium,      LABELS.LABEL_AssemblyMedium);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.AssemblyLarge,       LABELS.LABEL_AssemblyLarge);
            LabelManager.RegisterEnumTypeLabels(PrefabModelType.AssemblyHuge,        LABELS.LABEL_AssemblyHuge);
            
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Fungus , LABELS.LABEL_Fungus);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Flowers , LABELS.LABEL_Flowers);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Fern , LABELS.LABEL_Fern);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Grass , LABELS.LABEL_Grass);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.GroundCover , LABELS.LABEL_GroundCover);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Plant , LABELS.LABEL_Plant);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Crop , LABELS.LABEL_Crop);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Corn , LABELS.LABEL_Corn);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.AquaticPlant , LABELS.LABEL_AquaticPlant);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Boulder , LABELS.LABEL_Boulder);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Gravel , LABELS.LABEL_Gravel);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Stone , LABELS.LABEL_Stone);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Log , LABELS.LABEL_Log);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Branch , LABELS.LABEL_Branch);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Stump , LABELS.LABEL_Stump);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Trunk , LABELS.LABEL_Trunk);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Tree , LABELS.LABEL_Tree);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Leaves , LABELS.LABEL_Leaves);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Hillside , LABELS.LABEL_Hillside);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Ridge , LABELS.LABEL_Ridge);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Cliff , LABELS.LABEL_Cliff);
            LabelManager.RegisterEnumTypeLabels(PrefabContentType.Roots , LABELS.LABEL_Roots);
        
        }
    }
}
