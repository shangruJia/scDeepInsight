# This file describes how the sample query dataset is generated. Users don't have to run this script.
library(Seurat)
library(SeuratDisk)

query <- readRDS("query.rds")
n <- 100
query$n.assign <- sample(x = 1:n, size = ncol(query), replace = TRUE)
split.list <- SplitObject(query, split.by = 'n.assign')
q <- split.list[2]$`82`
SaveH5Seurat(q, filename = "query_sample.h5Seurat")
Convert("query_sample.h5Seurat", dest = "h5ad")
