# Alzheimer RNA-seq Analysis Report

## 1. Aim

To identify differentially expressed genes (DEGs) between Alzheimer's disease (AD) and control individuals in fusiform gyrus tissue.

This analysis was performed as a first step to explore which genes are altered in brain tissue in AD. The results are intended to generate hypotheses about disease mechanisms.

**What this study provides:**
- A reproducible measurement of gene expression differences between AD and control brain tissue.
- A shortlist of genes and biological processes worth examining in more detail.
- A documented, rerunnable pipeline that can be applied to larger datasets.

**What this study does not provide:**
- Proof that any gene causes the disease.
- A diagnostic or therapeutic tool.
- Conclusions that generalize to the whole AD population.

## 2. Data

- **Source:** NCBI SRA, BioProject PRJNA516886 (RNA expression in fusiform gyrus of AD and control subjects).
- **Samples:** 4 AD, 4 control. All female, aged 77 to 86 years.
- **Read type:** Single-end, Illumina HiSeq 2500.
- **Group definition:** AD samples were confirmed by the "Alzheimer's disease" diagnosis in the SRA records. Controls were selected from the same project and matched by age and sex.

| Sample | Group | Age |
|---|---|---|
| SRR8482664 | AD | 82 |
| SRR8482665 | AD | 77 |
| SRR8482727 | AD | 86 |
| SRR8482728 | AD | 86 |
| SRR8482739 | Control | 82 |
| SRR8482631 | Control | 78 |
| SRR8482734 | Control | 86 |
| SRR8482685 | Control | 85 |

## 3. Methods

1. **Data download:** FASTQ files were obtained with SRA Toolkit (`prefetch`, `fasterq-dump`).
2. **Quality control:** Each sample was assessed with FastQC. Basic quality and adapter checks passed. Typical RNA-seq warnings for overrepresented sequences and duplication levels were present.
3. **Trimming decision:** Adapter content was low (about 1-4%) and alignment rates were high, so no trimming was performed. For consistency across samples, all samples would have been trimmed or none; none were.
4. **Alignment:** Reads were aligned to the GRCh38 genome (Ensembl 110, primary assembly) with HISAT2 2.2.2 and sorted with samtools. Overall alignment rates were 94-96%.
5. **Counting:** Gene-level read counts were obtained with featureCounts 2.0.8 using the Ensembl 110 GTF. 62,754 genes were quantified.
6. **Differential expression:** DESeq2 with design `~ Group` and Control as the reference level. Adjusted p-values (padj) were computed with the Benjamini-Hochberg method.
7. **Annotation:** Ensembl IDs were mapped to gene symbols with org.Hs.eg.db.
8. **Visualization:** Volcano, MA and bar plots (script 07), and PCA and heatmap (script 08).

## 4. Results

- **Significant genes:** 59 genes with padj < 0.05.
- **Direction:** 49 genes higher in AD (log2FC > 0), 10 genes higher in control (log2FC < 0).
- **Expression level:** Median mean normalized count (baseMean) of significant genes was 228. None was below 10.
- **Effect size:** 56 of the 59 genes had |log2FC| > 1, i.e. at least a two-fold difference.
- **Top 20 genes:** Listed in `results/Top20_DEGs.csv` with gene symbols. 18 of the 20 are higher in AD.
- **Sample clustering:** In the PCA, the groups separate along PC1 (mean AD score -21, mean control score +21). Correlation of PC1 with age was 0.14 and with library size 0.29, so neither explains the separation well.

## 5. Interpretation

The findings are hypothesis-generating. Some significant genes may relate to glial, vascular and stress-response biology. This is a preliminary observation and has not been systematically compared with the published literature.

Clinical use would require independent validation and expert review.

## 6. Limitations

- **Sample size:** 4 versus 4. Results should be considered preliminary and require validation in an independent dataset.
- **Technical variables:** RIN (RNA integrity), post-mortem interval (PMI) and processing batch are not available in this dataset. Part of the PC1 separation may be technical.
- **Cell composition:** Differences in neuronal and glial proportions may have influenced some gene differences. This was not assessed.
- **Gene-level analysis:** Isoform-level analysis was not performed.
- **Multi-mapping reads:** Reads mapping to multiple genomic locations were excluded from counts (featureCounts default). Uniquely mapped reads made up 75-87% of alignments.

## 7. Next steps

1. Compare results with the published gene list of the original study.
2. Test the same genes in an independent AD fusiform gyrus dataset.
3. Estimate cell-type composition and assess its relationship with the gene differences.
4. Obtain technical metadata (RIN, PMI) to adjust for technical variation.

## 8. Reproduction

Run scripts 01 to 08 in order. HISAT2 index construction took about 12 minutes; alignment of all eight samples took about one hour.
