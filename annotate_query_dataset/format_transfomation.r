library(scater)
library(Seurat)
library(SeuratDisk)
#We accept both h5ad and h5seurat files as the input
#h5ad file to h5seurat file
path <- "/Usersdata/shangru/docker/pretrained_sample/"
Convert(file.path(path, "sample.h5ad"), dest = "h5seurat", overwrite = FALSE)

#h5seurat file to h5ad file
Convert(file.path(path, "sample.h5h5seurat"), dest = "h5ad")

#SingleCellExperiment file to h5seurat file
query <- readRDS("sample_sce.rds")
query <- Convert(from = query, to = "seurat")
SaveH5Seurat(query, filename= "sample_sce.h5seurat")

#SingleCellExperiment file to h5ad file
Convert(file.path(path, "sample_sce.h5seurat"), dest = "h5ad")