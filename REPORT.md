# Alzheimer RNA-Seq Differential Expression Analysis - Study Report

## 1. Objective

This study examines differences in gene expression levels using RNA-Seq
data from individuals diagnosed with Alzheimer's disease (AD) and healthy
control individuals. The goal is to identify differentially expressed
genes (DEGs) that may be associated with AD.

## 2. Dataset

| Sample ID | Group | Source |
|-----------|-------|--------|
| SRR8482664 | Control | NCBI SRA |
| SRR8482665 | Control | NCBI SRA |
| SRR8482727 | AD | NCBI SRA |
| SRR8482728 | AD | NCBI SRA |

- Sequencing type: Single-end RNA-Seq
- Reference genome: GRCh38 (Ensembl release 110)

## 3. Methods

The analysis was carried out through the following steps:

1. **Data Download**: Raw FASTQ files were downloaded from NCBI SRA.
2. **Quality Control**: Raw read quality was assessed with FastQC.
3. **Alignment**: Reads were aligned to the GRCh38 reference genome using
   HISAT2, producing sorted BAM files.
4. **Read Counting**: Gene-level read counts were computed with
   featureCounts, using the Homo_sapiens.GRCh38.110.gtf annotation.
5. **Differential Expression Analysis**: The DESeq2 (R/Bioconductor)
   package was used to compare the AD and Control groups.
6. **Gene Annotation**: Ensembl gene IDs were mapped to gene symbols using
   AnnotationDbi/org.Hs.eg.db.
7. **Visualization**: Volcano plot, MA plot, PCA plot, heatmap, and a bar
   plot of the top differentially expressed genes were generated
   (ggplot2, pheatmap).

## 4. Results

The resulting differential expression table is provided in
`Final_Results/final_results_with_symbols.csv`, while the top 20 most
significant genes are listed in `results/Top20_DEGs.csv`.

### Visualizations

- **Volcano Plot** (`figures/Volcano_Plot.png`): Shows the relationship
  between log2 fold change and statistical significance (adjusted
  p-value).
- **MA Plot** (`figures/ma_plot.png`): Shows fold change relative to mean
  expression level.
- **PCA Plot** (`figures/PCA.png`): Shows overall variation among samples
  and separation between groups.
- **Heatmap** (`figures/Heatmap.png`): Shows the expression pattern of the
  most significant genes across samples.
- **Top Genes Bar Plot** (`figures/top_genes_barplot.png`): Summarizes the
  top 20 up/down-regulated genes.

## 5. Limitations

- The sample size is small (2 samples per group), which limits
  statistical power; results should be regarded as preliminary findings.
- Single-end sequencing was used; paired-end data could provide more
  precise transcript-level quantification.
- Increasing the number of biological replicates would improve the
  reliability of the findings.

## 6. Conclusion

This pilot analysis presents a workflow revealing gene expression
differences between AD and control groups. The identified differentially
expressed genes can be considered candidates for further research into
the molecular mechanisms of Alzheimer's disease.

## 7. Recommendations and Future Work

The following steps are recommended to strengthen the findings of this
pilot study and make them more biologically and clinically meaningful:

1. **Increase Sample Size**: Two samples per group severely limits
   statistical power. Repeating the analysis with at least 5-6
   biological replicates per group would improve the reliability of
   the results.

2. **Functional Enrichment Analysis (GO/KEGG Enrichment)**: Gene Ontology
   (GO) and KEGG pathway analysis should be performed to determine which
   biological processes, cellular components, and molecular functions
   the identified DEGs are involved in (e.g. using clusterProfiler or
   enrichR packages).

3. **Comparison with Known Alzheimer-Associated Genes**: The identified
   DEGs should be checked for overlap with well-known Alzheimer's
   disease genes in the literature, such as APOE, APP, PSEN1, PSEN2,
   and MAPT.

4. **Experimental Validation**: The expression differences of top genes
   found via RNA-Seq should be validated using independent methods such
   as qRT-PCR or Western Blot.

5. **Batch Effect and Confounder Control**: As sample size increases,
   confounding variables such as age, sex, and post-mortem interval
   should be included in the model (added as covariates in the DESeq2
   design formula).

6. **Paired-End Sequencing**: Using paired-end sequencing in future
   experiments would allow more accurate quantification of transcript
   isoforms and splice variants.

7. **Meta-Analysis with Public Datasets**: Performing a meta-analysis
   with similar Alzheimer's RNA-Seq datasets available on GEO/SRA would
   be valuable for testing the generalizability of the findings.

## 8. References

- Love, M.I., Huber, W., Anders, S. (2014). Moderated estimation of fold
  change and dispersion for RNA-seq data with DESeq2. Genome Biology.
- Kim, D., Paggi, J.M., Park, C. et al. (2019). Graph-based genome
  alignment and genotyping with HISAT2 and HISAT-genotype. Nature
  Biotechnology.
- Liao, Y., Smyth, G.K., Shi, W. (2014). featureCounts: an efficient
  general purpose program for assigning sequence reads to genomic
  features. Bioinformatics.
- Ensembl GRCh38 release 110, [ensembl.org](https://www.ensembl.org)
