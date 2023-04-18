library(Seurat)
library(SeuratDisk)

# First set path, users can replace it with the folder where they store the reference and query datasets.
path <- "/Usersdata/shangru/docker/pretrained_sample/"
# This script requires three input file to generate the output file "merge_sct.h5ad", which is used in the annoation process.
# When annotating customized dataset, users only have to change input 2 to the targeted dataset.
# Load reference dataset, which can be downloaded directly from cellxgene website.
# Input 1: Reference dataset.
start <- proc.time()
reference <- readRDS(file.path(path, "reference.rds"))
# Then load query dataset. The sample query dataset is also provied in the Github repository.
# Script of how the sample query dataset is sliced is available in the Additional folder.
# Input 2: Query dataset.
Convert(file.path(path, "sample.h5ad"), dest = "h5seurat", overwrite = FALSE)
query <- LoadH5Seurat(file.path(path, "sample.h5seurat"))
# Input 3: Genes analyzed in the pretrained model.
gene_list <- unlist(read.csv(file.path(path, "pretrained_genes.csv"))["gene_ids"])
# Slice the reference dataset and query dataset by genes analyzed in the pretrained model.
reference <- subset(reference, features=gene_list)
query <- subset(query, features=gene_list)
# Add feature "orig" and set genes in the query dataset as variable genes.
reference@meta.data["orig"] = "reference"
query@meta.data["orig"] = "query"
merge <- merge(reference, y=query)
VariableFeatures(merge) <- query$RNA@data@Dimnames[[1]]
# Perorm normalization.
merge.list <- SplitObject(merge, split.by = "orig")
merge.list <- lapply(X = merge.list, FUN = SCTransform, method = "glmGamPoi")
# Perorm batch effect correction between the reference dataset and sample query dataset in the integration process.
fq <- SelectIntegrationFeatures(object.list = merge.list, nfeatures = 3000)
merge.list <- PrepSCTIntegration(object.list = merge.list, anchor.features = fq)
# merge.list[1] is the reference dataset, use it as the reference set in the integration process. 
merge.anchors <- FindIntegrationAnchors(object.list = merge.list, normalization.method = "SCT", anchor.features = fq, reference=1)
sct <- IntegrateData(anchorset = merge.anchors, normalization.method = "SCT")
SaveH5Seurat(sct, assay = "integrated", filename = file.path(path,"merge_sct.h5Seurat"))
# Output: "merge_sct.h5ad", which is used in the "test_on_query.ipynb" annoation notebook.
Convert(file.path(path,"merge_sct.h5Seurat"), assay = "integrated", dest = "h5ad")
# Calculate the whole time cost in the batch effect correction process. The system time could be used to measure the time cost.
time_cost <- proc.time() - start
