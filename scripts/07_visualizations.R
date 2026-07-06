



# ============================================
# RNA-Seq Visualization Script
# ============================================

# Load libraries
library(DESeq2)
library(ggplot2)
library(pheatmap)
library(RColorBrewer)

# Set working directory
setwd("~/Ngs_analysis/Alzheimer_RNASeq_Differential_Expression_Analysis")

# Read results
results <- read.csv("Final_Results/final_results_with_symbols.csv")

# ============================================
# 1. VOLCANO PLOT
# ============================================

results$significance <- "Not Significant"
results$significance[results$log2FoldChange > 1 & results$padj < 0.05] <- "Upregulated"
results$significance[results$log2FoldChange < -1 & results$padj < 0.05] <- "Downregulated"

volcano <- ggplot(results, aes(x = log2FoldChange, y = -log10(padj), color = significance)) +
  geom_point(alpha = 0.6, size = 1.5) +
  scale_color_manual(values = c("Downregulated" = "blue", "Not Significant" = "gray", "Upregulated" = "red")) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "black") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") +
  labs(title = "Volcano Plot: AD vs Control",
       x = "Log2 Fold Change",
       y = "-Log10 Adjusted P-value") +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave("figures/volcano_plot.png", volcano, width = 8, height = 6, dpi = 300)

# ============================================
# 2. MA PLOT
# ============================================

ma_plot <- ggplot(results, aes(x = log10(baseMean), y = log2FoldChange, color = significance)) +
  geom_point(alpha = 0.6, size = 1.5) +
  scale_color_manual(values = c("Downregulated" = "blue", "Not Significant" = "gray", "Upregulated" = "red")) +
  geom_hline(yintercept = 0, linetype = "solid", color = "black") +
  labs(title = "MA Plot: AD vs Control",
       x = "Log10 Mean Expression",
       y = "Log2 Fold Change") +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave("figures/ma_plot.png", ma_plot, width = 8, height = 6, dpi = 300)

# ============================================
# 3. TOP GENES BAR PLOT
# ============================================

top_up <- head(results[order(-results$log2FoldChange), ], 10)
top_down <- head(results[order(results$log2FoldChange), ], 10)
top_genes <- rbind(top_up, top_down)

bar_plot <- ggplot(top_genes, aes(x = reorder(symbol, log2FoldChange), y = log2FoldChange, fill = log2FoldChange > 0)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("TRUE" = "red", "FALSE" = "blue"), labels = c("Down", "Up")) +
  coord_flip() +
  labs(title = "Top 20 Differentially Expressed Genes",
       x = "Gene Symbol",
       y = "Log2 Fold Change",
       fill = "Direction") +
  theme_minimal()

ggsave("figures/top_genes_barplot.png", bar_plot, width = 8, height = 6, dpi = 300)

print("Visualizations saved to figures/")
