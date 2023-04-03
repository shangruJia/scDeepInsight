# scDeepInsight
- A supervised single-cell annotation method
- The paper of scDeepInsight has been uploaded to bioRxiv: [scDeepInsight: a supervised cell-type identification method for scRNA-seq data with deep learning](https://www.biorxiv.org/content/10.1101/2023.03.09.531861v1)

#### 1. Introduction of the pipeline 
![](https://github.com/shangruJia/scDeepInsight/blob/main/figures/workflow.png)

#### 2. Instructions
- (a) How can we download the reference and query datasets?
<br> Both the reference dataset and raw query dataset can be downloaded from cellxgene website.
<br> The PBMC dataset is available from: [PBMC reference dataset](https://cellxgene.cziscience.com/collections/b0cf0afa-ec40-4d65-b570-ed4ceacc6813). 
<br> The initial query dataset can be accessed from: [RAW query dataset](https://cellxgene.cziscience.com/collections/dde06e0f-ab3b-46be-96a2-a8082383c4a1).
<br> A sample query dataset, which is a slice of the raw query dataset(random sampling), is also provided in this the folder: pretrained_sample. Users can use this sample query dataset and provided pretrained model to have a quick start using scDeepInsight.
 
- (b) Where the pretrained model and sample query dataset are stored?
<br> All files (six files) to annotate the sample query dataset are provided in this folder: pretrained_sample. 
<br> (1) In this folder, checkpoint_model_pre.pth is the pretrained model on reference dataset. 
<br> (2) img_transformer_pre.obj is the trained image transformer to convert query dataset to images.
<br> (3) label_encoder_pre.obj is the label encoder used in the pre-training process.
<br> (4) pretrained_genes.csv records 3,000 genes analyzed in the pretrained model.
<br> (5) sample.h5ad is the sample query dataset. Details about how this query dataset is sliced from the raw query dataset is in the Additional File folder.
<br> (6) real_sample_labels.csv records the expert annotated cell-type labels of the sample query dataset in previous study.

- (b) Conduct preprocessing and batch effect correction.
<br> To annotate target query dataset, users should first perform normalization and batch effect correction between their query dataset and the reference dataset. 
<br> These processes are discribed in the file batch_effect_correction.r, which is in the Annotate query dataset folder.

- (c) Utilize pretrained model to annotate query dataset. 
<br> After finnishing preprocessing the query dataset, users can use scDeepInsight to convert non-image processed data to images using pretrained image transformer. Then converted figures are fed into pretrained model to annotate cell types of this query dataset. 
<br> Detailed process are mentioned in the file test_on_query.ipynb, which is also in the Annotate query dataset folder. 


#### 3. Environment information
- (Python) Anndata: 0.8.0
- (R )Seurat 4.2.0
- (R) SeuratDisk: 0.0.0.9020
