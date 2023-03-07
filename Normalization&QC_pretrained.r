library(Seurat)
library(SeuratDisk)
library(ggplot2)
library(dplyr)

reference <- LoadH5Seurat("reference.h5Seurat")
# nCount_RNA
reference@meta.data["nCount_RNA"] <- colSums(x = reference, slot = "counts")  
# nFeature_RNA
reference@meta.data["nFeature_RNA"] <- colSums(x = GetAssayData(object = reference, slot = "counts") > 0)
# percent.mt
reference <- PercentageFeatureSet(reference, pattern = "^MT-", col.name = "percent.mt")
as_tibble(
  reference[[]],
  rownames="Barcodes"
) -> qc.metrics

head(qc.metrics)
theme_set(theme_bw(base_size = 30))
dev.set(dev.prev())
png(file = "quality_control.png", width = 4000, height = 4000) 
qc.metrics %>%
  arrange(percent.mt) %>%
  ggplot(aes(nCount_RNA,nFeature_RNA)) + 
  theme(text = element_text(size = 55)) +
  geom_point(aes(color=percent.mt),size=5) + 
  scale_color_gradientn(colors=c("purple","blue","green","yellow","red"), limits=c(0,20)) +
  guides(colour = guide_coloursteps(show.limits = TRUE, barheight=30))+
  ggtitle("QC metrics") +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_hline(yintercept = 300) +
  geom_hline(yintercept = 4000) +
  scale_x_log10() + scale_y_log10() +
  theme(plot.margin = unit(c(2,2,2,2), "cm"))
dev.off()

reference <- subset(reference, subset = nFeature_RNA > 300 & nFeature_RNA < 4000 & percent.mt < 15)
#157507 samples, 25207 features
reference <- SCTransform(reference, method = "glmGamPoi", variable.features.n = 3000, vars.to.regress = "percent.mt", verbose = TRUE)
SaveH5Seurat(reference, filename = "reference_sct.h5Seurat")
Convert("reference_sct.h5Seurat", assay = "SCT", dest = "h5ad")