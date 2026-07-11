# Alzheimer RNA-Seq Differential Expression Analysis

End-to-end RNA-Seq pipeline for differential gene expression analysis between Alzheimer's disease (AD) and control samples.

## Project Overview

| Feature | Value |
|---------|-------|
| Organism | Homo sapiens |
| Reference Genome | GRCh38 (Ensembl 110) |
| Sample Count | 4 (2 AD, 2 Control) |
| Sequencing Type | Single-end RNA-Seq |
| Analysis Tools | FastQC, HISAT2, featureCounts, DESeq2 |

## Samples

| Sample ID | Group |
|-----------|-------|
| SRR8482664 | Control |
| SRR8482665 | Control |
| SRR8482727 | AD |
| SRR8482728 | AD |

Data Source: NCBI SRA

## Project Structure

- Final_Results/    -> Annotated final DE results
- analysis/
  - alignment/      -> Sorted BAM files
  - counts/         -> featureCounts output
  - qc/             -> FastQC reports
- data/
  - metadata/       -> Sample info (samples.csv)
  - raw_fastq/      -> Raw FASTQ files
  - reference/      -> Reference genome, GTF, HISAT2 index
- figures/          -> Volcano plot, PCA, Heatmap, MA plot, top genes barplot
- results/          -> DESeq2 results, Top20 DEGs
- scripts/          -> Pipeline scripts (01-07)

## Pipeline Steps

1. Data download - 01_download_data.sh
2. Quality control - 02_fastqc.sh
3. Alignment (HISAT2) - 03_hisat2_alignment.sh
4. Read counting (featureCounts) - 04_featureCounts.sh
5. Differential expression (DESeq2) - 05_deseq2_analysis.R
6. Gene annotation - 06_gene_annotation.R
7. Visualizations (Volcano, MA, PCA, Heatmap) - 07_visualizations.R

## Results

- Final annotated results: Final_Results/final_results_with_symbols.csv
- Top 20 DEGs: results/Top20_DEGs.csv
- Full DE table: results/differential_expression_results.csv

## Requirements

- FastQC
- HISAT2
- Subread (featureCounts)
- R (DESeq2, AnnotationDbi, org.Hs.eg.db, ggplot2, pheatmap)
