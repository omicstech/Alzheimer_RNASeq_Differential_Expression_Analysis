# 08_pca_heatmap.R
# Ornekler arasi benzerlik (PCA) ve en anlamli 20 genin isi haritasi.
# Calistirma: proje klasorunun icinden  Rscript scripts/08_pca_heatmap.R

library(DESeq2)
library(ggplot2)
library(pheatmap)

# 1. Sayimlari ve ornek bilgisini oku (05 ile ayni)
counts_raw <- read.delim("analysis/counts/all_samples_counts.txt",
                         comment.char = "#", row.names = 1, check.names = FALSE)
counts <- counts_raw[, 6:ncol(counts_raw)]
colnames(counts) <- sub("_sorted.bam", "", basename(colnames(counts)))
coldata <- read.csv("data/metadata/samples.csv", row.names = "Sample_ID")
coldata$Group <- factor(coldata$Group, levels = c("Control", "AD"))
counts <- counts[, rownames(coldata)]

# 2. Sayimlari grafik icin uygun olcege cevir (vst)
dds <- DESeqDataSetFromMatrix(countData = counts, colData = coldata, design = ~ Group)
vsd <- vst(dds, blind = TRUE)

# 3. PCA grafigi
pca <- plotPCA(vsd, intgroup = "Group", returnData = TRUE)
pct <- round(100 * attr(pca, "percentVar"))
p <- ggplot(pca, aes(x = PC1, y = PC2, color = Group, label = name)) +
  geom_point(size = 4) +
  geom_text(vjust = -1, size = 3, show.legend = FALSE) +
  scale_x_continuous(expand = expansion(mult = 0.2)) +
  labs(title = "PCA: AD vs Control",
       x = paste0("PC1: ", pct[1], "% varyans"),
       y = paste0("PC2: ", pct[2], "% varyans")) +
  theme_minimal()
ggsave("figures/PCA.png", p, width = 8, height = 6, dpi = 300)

# 4. Isi haritasi: en anlamli 20 gen
top20 <- rownames(read.csv("results/Top20_DEGs.csv", row.names = 1))
mat <- assay(vsd)[top20, ]
mat <- mat - rowMeans(mat)
sym <- read.csv("results/DEGs_with_gene_symbols.csv", row.names = 1)[top20, "symbol"]
rownames(mat) <- make.unique(ifelse(is.na(sym), top20, sym))
ann <- data.frame(Group = coldata$Group, row.names = rownames(coldata))
pheatmap(mat, annotation_col = ann, filename = "figures/Heatmap.png",
         width = 7, height = 6)
