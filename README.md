# scDeepInsight

scDeepInsight is a supervised deep learning-based single-cell method for annotation of single-cell RNA-sequencing datasets. This repository provies the code for core method imlementation as well as optional batch correction scripts. Batch correction is recommended for cases when a reference dataset was produced in a different experement than the dataset being annotated. We also include a pre-trained models that can be used for anntation of periferal blood mononuclear cell types. 


Please see the following pre-print for additional details (bioRxiv): scDeepInsight: a supervised cell-type identification method for scRNA-seq data with deep learning Shangru Jia, Artem Lysenko, Keith A Boroevich, Alok Sharma, Tatsuhiko Tsunoda
bioRxiv 2023.03.09.531861; [doi: https://doi.org/10.1101/2023.03.09.531861](https://www.biorxiv.org/content/10.1101/2023.03.09.531861v1)

#### **1. Installation**

The packged version of the tool can be installed using the following command:

    pip3 install scdeepinsight
    
This package was tested and confirmed working with PyTroch v1.12.0 / CUDA v10.2 (NVIDIA-SMI:440.64). Note that if no GPU is avaiable on your system, a CPU-only mode is also supported.

Alternatively, a Docker image is also available and can be obtained as follows:

    docker pull shangrujia/scdeepinsight

#### **2. Pipeline overview**

<img src="https://github.com/shangruJia/scDeepInsight-additional/blob/main/Figures/workflow.png" width="700">

#### **3. Instructions**

The following process illustrates a typical run of scDeepInsight using a small example and addtional explanation about where to get the data and how to modify the the process in order to annotate your own datasets.

The commands for running the included example are:

```python
    from scdeepinsight import pbmc
    
    pbmc.ImageTransform("sample.h5ad", "barcode.csv", "image.npy")
    
    pred_label = pbmc.Annotate("barcode.csv", "image.npy", batch_size=128)
```
*Description of addtional files*
The six files used during annotation of the sample query dataset are provided in the 'pretrained_sample' folder: . We have provided pretained models both with batch efect correction and with out batch efect correction. For the pretrained model without correction, please refer to: [pretrained_nobc](https://github.com/shangruJia/scDeepInsight/blob/main/pretrained_files/pretrained_nobc/checkpoint_model_pre.pth)
  - (1) In this folder, [checkpoint_model_pre.pth](https://github.com/shangruJia/scDeepInsight/tree/main/pretrained_files/pretrained_withbc/checkpoint_model_pre.pth) is the pre-trained model on reference dataset. 
  - (2) [img_transformer_pre.obj](https://github.com/shangruJia/scDeepInsight/tree/main/pretrained_files/pretrained_withbc/img_transformer_pre.obj) is the trained image transformer to convert query dataset to images.
  - (3) [label_encoder_pre.obj](https://github.com/shangruJia/scDeepInsight/tree/main/pretrained_files/pretrained_withbc/label_encoder_pre.obj) is the label encoder used in the pre-training process.
  - (4) [pretrained_genes.csv](https://github.com/shangruJia/scDeepInsight/tree/main/pretrained_files/pretrained_withbc/pretrained_genes.csv) records 3,000 genes analyzed in the pretrained model.
  - (5) [sample.h5ad](https://github.com/shangruJia/scDeepInsight/blob/main/sample_dataset/sample.h5ad) is the sample query dataset. Details about how this query dataset is sliced from the raw query dataset is in the Additional File folder.
  - (6) [real_sample_labels.csv](https://github.com/shangruJia/scDeepInsight/blob/main/sample_dataset/real_sample_labels.csv) records the expert annotated cell-type labels of the sample query dataset in previous study.

A more comprehensive analysis workflow, which was used for the scDeepInsgiht paper is shared in its own repository, availabe [here](https://github.com/shangruJia/scDeepInsight-additional) To setup an analysis of your own datasets please follow the steps outlined below.

- (a) *Obtaining additional annotated datasets*
<br> Both the reference dataset and raw query dataset can be downloaded from cellxgene website.
<br> The PBMC dataset is available from: [PBMC reference dataset](https://cellxgene.cziscience.com/collections/b0cf0afa-ec40-4d65-b570-ed4ceacc6813). 
<br> The initial query dataset can be accessed from: [RAW query dataset](https://cellxgene.cziscience.com/collections/dde06e0f-ab3b-46be-96a2-a8082383c4a1).
<br> A sample query dataset, which is a slice of the raw query dataset produced using random sampling, is also provided the 'pretrained_sample' folder. This sample query dataset and provided pre-trained model can be used to quickly test your instation of scDeepInsight.

- (b) *Performing the annotation*
<br> The annotation process is done in two steps, the required scripts are stored in the Annotate query dataset folder:
  - (1) The preprocessing and batch effect correction process.
<br>  To annotate target query dataset, users should first perform normalization and batch effect correction between their query dataset and the reference dataset. These processes are described in the file [batch_effect_correction.r](https://github.com/shangruJia/scDeepInsight/blob/main/annotate_query_dataset/scDeepInsight/batch_effect_correction.r),
  - (2) Use the pre-trained model to annotate query dataset. 
<br> After finnishing preprocessing the query dataset, users can use scDeepInsight to convert non-image processed data to images using pre-trained image transformer. Then converted figures are fed into pre-trained model to annotate cell types of this query dataset. Detailed process are mentioned in the file [test_on_query.ipynb](https://github.com/shangruJia/scDeepInsight/blob/main/annotate_query_dataset/scDeepInsight/test_on_query.ipynb). 

- (c) *Annotating custom datasets*
<br> To annotate your own datasets, replace the query dataset accordingly and then perform the same batch effect correction and annotaion steps as shown in the example. If there is no new reference dataset, provided reference dataset and pre-trained model can be re-used to do your own annotation.

### **4 Links**

- scDeepInsight on PyPI: [scdeepinsight](https://pypi.org/project/scdeepinsight/). Users can refer to [Tutorial](https://github.com/shangruJia/scDeepInsight/blob/main/Tutorial.ipynb) to figure out how to use this package.
- DockerHub: [Docker Image](https://hub.docker.com/r/shangrujia/scdeepinsight).

#### **5. Environment information**
- (Python) Anndata: 0.9.1
- (R) Seurat 4.2.0
- (R) SeuratDisk: 0.0.0.9020

#### **6. Release notes**
The latest verson of scDeepInsight is 1.1.1
