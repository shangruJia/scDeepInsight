library(Seurat)
library(SeuratDisk)

reference <- readRDS("reference.rds")
query <- LoadH5Seurat("query_sample.h5Seurat")
gene_list <- unlist(read.csv("./pretrained/pretrained_genes.csv")["gene_ids"])
# Select genes analyzed in the pretrained model in the reference dataset and query dataset
reference <- subset(reference, features=gene_list)
query <- subset(query, features=gene_list)
reference@meta.data["orig"] = "reference"
query@meta.data["orig"] = "query"
merge <- merge(reference, y=query)
VariableFeatures(merge) <- query$RNA@data@Dimnames[[1]]
#Perorm normalization
merge.list <- SplitObject(merge, split.by = "orig")
merge.list <- lapply(X = merge.list, FUN = SCTransform, method = "glmGamPoi")
#Perorm batch effect correction between the reference dataset and sample query dataset in the integration process
fq <- SelectIntegrationFeatures(object.list = merge.list, nfeatures = 3000)
merge.list <- PrepSCTIntegration(object.list = merge.list, anchor.features = fq)
merge.anchors <- FindIntegrationAnchors(object.list = merge.list, normalization.method = "SCT", anchor.features = fq, reference=1)
sct <- IntegrateData(anchorset = merge.anchors, normalization.method = "SCT")
SaveH5Seurat(sct, assay = "integrated", filename = "merge_sct.h5Seurat")
Convert("merge_sct.h5Seurat", assay = "integrated", dest = "h5ad")





















sample = pd.read_csv("./sample/sample_query.csv", index_col=0)


