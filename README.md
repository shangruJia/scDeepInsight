# scDeepInsight
- A supervised single-cell annotation method
- The paper of scDeepInsight has been uploaded to bioRxiv: [scDeepInsight: a supervised cell-type identification method for scRNA-seq data with deep learning](https://www.biorxiv.org/content/10.1101/2023.03.09.531861v1)

#### 1. Introduction of the pipeline 
![](https://github.com/shangruJia/scDeepInsight/blob/main/figures/workflow.png)

#### 2. Instructions
- (a) Download of reference and query datasets. <br> Both the reference dataset and raw query dataset can be downloaded from cellxgene website. <br> The PBMC dataset is available from: [PBMC reference dataset](https://cellxgene.cziscience.com/collections/b0cf0afa-ec40-4d65-b570-ed4ceacc6813). <br> The initial query dataset can be accessed from: [RAW query dataset](https://cellxgene.cziscience.com/collections/b0cf0afa-ec40-4d65-b570-ed4ceacc6813). <br> A sample query dataset, which is a slice of the raw query dataset(random sampling), is also provided in this the folder: Annotate query dataset/sample query dataset. Users can use this sample query dataset and provided pretrained model to have a quick start using scDeepInsight.
  
- (b) Conduct preprecessing and batch effect correction.
<br> To annotate target query dataset, users should first perform normalization and batch effect correction between their query dataset and the reference dataset. These processes are discribed in the file batch_effect_correction.r, which is in the Annotate query dataset folder.

- (c) Utilize pretrained model to annotate query dataset. 
-<br> After finnishing preprocessing the query dataset, users can use scDeepInsight to convert non-image processed data to images using pretrained image transformer. Then converted figures are fed into pretrained model to annotate cell types of this query dataset. Detailed process are mentioned in the file test_on_query.ipynb, which is also in the Annotate query dataset folder. Pretained model, image transormer, label encoder are provided in the folder: Model pretraining/pretrained model.

#### 3. Environment information
- (Python) Anndata: 0.8.0
- (R )Seurat 4.2.0
- (R) SeuratDisk: 0.0.0.9020
