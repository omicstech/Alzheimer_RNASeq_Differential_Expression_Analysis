# Figures

These figures were produced from 8 samples: 4 AD and 4 control.

**Thresholds:** padj < 0.05 (Benjamini-Hochberg); |log2FC| > 1.
**Direction:** a positive log2FC means higher expression in AD; a negative log2FC means higher expression in control. The reference group is control.

## Volcano_Plot.png

Each point is a gene. The x-axis shows log2FC (size and direction of change). The y-axis shows -log10(padj) (strength of evidence). Red points are higher in AD and significant (49 genes). Blue points are higher in control and significant (10 genes). Grey points are not significant. Dashed vertical lines mark log2FC = ±1; the dashed horizontal line marks padj = 0.05.

## ma_plot.png

The x-axis shows mean expression (log10 baseMean) and the y-axis shows log2FC. The point cloud should be centered on zero. Low-expression genes spread more widely, which is expected.

## PCA.png

Each point is a sample, based on the 500 most variable genes. Samples from the same group should cluster together. The PC1 and PC2 percentages show how much of the total variation each axis explains. Separation may reflect disease or technical differences.

## Heatmap.png

The top 20 significant genes across the 8 samples. Colors are relative to each gene's own mean: red is above the mean, blue is below. The top bar shows the group (AD or control). The dendrogram shows sample similarity.

## top_genes_barplot.png

Among significant genes, the 10 with the highest log2FC (higher in AD) and the 10 with the lowest log2FC (higher in control). Only 10 significant genes are higher in control, so all of them are shown.

## Method note

Small sample (4 vs 4). Results should be treated as preliminary findings.