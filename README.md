# scDeepInsight
- A supervised single-cell annotation method
- The paper of scDeepInsight has been uploaded to bioRxiv: [scDeepInsight: a supervised cell-type identification method for scRNA-seq data with deep learning](https://www.biorxiv.org/content/10.1101/2023.03.09.531861v1)

#### **1. Introduction of the pipeline**
![](https://github.com/shangruJia/scDeepInsight/blob/main/figures/workflow.png)

#### **2. Instructions**
- (a) *How can we download the reference and query datasets?*
<br> Both the reference dataset and raw query dataset can be downloaded from cellxgene website.
<br> The PBMC dataset is available from: [PBMC reference dataset](https://cellxgene.cziscience.com/collections/b0cf0afa-ec40-4d65-b570-ed4ceacc6813). 
<br> The initial query dataset can be accessed from: [RAW query dataset](https://cellxgene.cziscience.com/collections/dde06e0f-ab3b-46be-96a2-a8082383c4a1).
<br> A sample query dataset, which is a slice of the raw query dataset (random sampling), is also provided in this the folder: pretrained_sample. Users can use this sample query dataset and provided pre-trained model to have a quick start using scDeepInsight.
 
- (b) *Where are the pre-trained model and sample query dataset stored?*
<br> All files (six files) to annotate the sample query dataset are provided in this folder: pretrained_sample. 
  - (1) In this folder, [checkpoint_model_pre.pth](https://github.com/shangruJia/scDeepInsight/blob/main/pretrained_sample/checkpoint_model_pre.pth) is the pre-trained model on reference dataset. 
  - (2) [img_transformer_pre.obj](https://github.com/shangruJia/scDeepInsight/blob/main/pretrained_sample/img_transformer_pre.obj) is the trained image transformer to convert query dataset to images.
  - (3) [label_encoder_pre.obj](https://github.com/shangruJia/scDeepInsight/blob/main/pretrained_sample/label_encoder_pre.obj) is the label encoder used in the pre-training process.
  - (4) [pretrained_genes.csv](https://github.com/shangruJia/scDeepInsight/blob/main/pretrained_sample/pretrained_genes.csv) records 3,000 genes analyzed in the pretrained model.
  - (5) [sample.h5ad](https://github.com/shangruJia/scDeepInsight/blob/main/pretrained_sample/sample.h5ad) is the sample query dataset. Details about how this query dataset is sliced from the raw query dataset is in the Additional File folder.
  - (6) [real_sample_labels.csv](https://github.com/shangruJia/scDeepInsight/blob/main/pretrained_sample/real_sample_labels.csv) records the expert annotated cell-type labels of the sample query dataset in previous study.

- (c) *How to annotate the sample query dataset using pre-trained model?*
<br> The annotation process contains two steps, two scripts are stored in the Annotate query dataset folder:
  - (1) The preprocessing and batch effect correction process.
<br>  To annotate target query dataset, users should first perform normalization and batch effect correction between their query dataset and the reference dataset. These processes are described in the file [batch_effect_correction.r](https://github.com/shangruJia/scDeepInsight/blob/main/Annotate%20query%20dataset/batch_effect_correction.r),
  - (2) Utilize pre-trained model to annotate query dataset. 
<br> After finnishing preprocessing the query dataset, users can use scDeepInsight to convert non-image processed data to images using pre-trained image transformer. Then converted figures are fed into pre-trained model to annotate cell types of this query dataset. Detailed process are mentioned in the file [test_on_query.ipynb](https://github.com/shangruJia/scDeepInsight/blob/main/Annotate%20query%20dataset/test_on_query.ipynb). 

- (d) *How to annotate customized query dataset using pre-trained model?*
<br> To annotate customized query dataset, users only have to change the query dataset to their target dataset and perform the same batch effect correction and annotaion process. The reference dataset and pre-trained model do not have to be changed.

#### **3. Environment information**
- (Python) Anndata: 0.8.0
- (R )Seurat 4.2.0
- (R) SeuratDisk: 0.0.0.9020
