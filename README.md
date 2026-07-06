# Alzheimer's RNA-seq Differential Expression Analysis

## Project Overview

This project presents a complete RNA-seq differential expression analysis workflow for identifying genes with altered expression patterns between Alzheimer's disease samples and control samples.

The analysis includes quality control, read alignment, gene quantification, differential expression analysis, functional annotation, and visualization of significant expression changes.

---

## Research Objective

The main objective of this project is to identify differentially expressed genes associated with Alzheimer's disease using publicly available RNA-seq data.

The workflow aims to:

- Process raw sequencing data
- Perform quality assessment
- Generate gene-level expression counts
- Identify significantly differentially expressed genes
- Visualize expression patterns between disease and control groups

---

## Data Source

RNA-seq data were obtained from publicly available sequencing datasets.

Raw sequencing reads were processed through a standard RNA-seq pipeline:

- Quality control
- Genome alignment
- Gene quantification
- Differential expression analysis

---

## Analysis Workflow

### 1. Quality Control

Raw sequencing reads were evaluated using FastQC.

Generated reports:

- Per-base quality assessment
- Sequence quality distribution
- Adapter contamination checks

---

### 2. Read Alignment

Reads were aligned to the reference genome using HISAT2.

Output:

- Aligned sequencing reads
- Alignment statistics

---

### 3. Gene Quantification

Gene-level read counts were generated using featureCounts.

Output:

- Count matrix used for downstream analysis

---

### 4. Differential Expression Analysis

Differential expression analysis was performed using DESeq2.

Criteria used for identifying significant genes:

- Adjusted p-value < 0.05
- Absolute log2 fold change threshold

---

## Visualization

Generated figures include:

- PCA plot
- Volcano plot
- MA plot
- Heatmap
- Top differentially expressed genes bar plot

All figures are stored in:

---

## Project Structure

Alzheimer_RNASeq_Differential_Expression_Analysis/

├── scripts/
│   ├── 01_download_data.sh
│   ├── 02_fastqc.sh
│   ├── 03_hisat2_alignment.sh
│   ├── 04_featureCounts.sh
│   ├── 05_deseq2_analysis.R
│   ├── 06_gene_annotation.R
│   └── 07_visualizations.R
│
├── results/
│   ├── differential_expression_results.csv
│   └── Top20_DEGs.csv
│
├── figures/
│   ├── PCA.png
│   ├── Volcano_Plot.png
│   ├── Heatmap.png
│   ├── ma_plot.png
│   └── top_genes_barplot.png
│
└── README.md
## Project Structure

```text
Alzheimer_RNASeq_Differential_Expression_Analysis/

├── scripts/
│   ├── 01_download_data.sh
│   ├── 02_fastqc.sh
│   ├── 03_hisat2_alignment.sh
│   ├── 04_featureCounts.sh
│   ├── 05_deseq2_analysis.R
│   ├── 06_gene_annotation.R
│   └── 07_visualizations.R

├── results/
│   ├── differential_expression_results.csv
│   └── Top20_DEGs.csv

├── figures/
│   ├── PCA.png
│   ├── Volcano_Plot.png
│   ├── Heatmap.png
│   ├── ma_plot.png
│   └── top_genes_barplot.png

└── README.md
