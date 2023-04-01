library(Seurat)
library(SeuratDisk)

query <- readRDS("query.rds")
n <- 100
query$n.assign <- sample(x = 1:n, size = ncol(query), replace = TRUE)
split.list <- SplitObject(query, split.by = 'n.assign')
q <- split.list[2]$`82`
SaveH5Seurat(q, filename = "./sample/sample.h5Seurat")
Convert("./sample/sample.h5Seurat", dest = "h5ad")