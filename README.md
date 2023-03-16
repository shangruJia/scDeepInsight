# scDeepInsight
- A supervised single-cell annotation method
- The paper of scDeepInsight has been uploaded to bioRxiv: [scDeepInsight: a supervised cell-type identification method for scRNA-seq data with deep learning](https://www.biorxiv.org/content/10.1101/2023.03.09.531861v1)

#### 1. Introduction of the pipeline 
![](https://github.com/shangruJia/scDeepInsight/blob/main/figures/workflow.png)

#### 2. Instructions
- (a) Download of reference and query datasets. The reference dataset can be downloaded from: [PBMC reference dataset](https://atlas.fredhutch.org/nygc/multimodal-pbmc/)
  
  A sample query dataset is provided in this repository.
- (b) Conduct preprecessing and batch effect correction.
- (c) Utilize pretrained model to annotate query dataset.

#### 3. Environment information
- (Python) Anndata: 0.7.6
- (R )Seurat 4.2.0
- (R) SeuratData: 0.2.2
