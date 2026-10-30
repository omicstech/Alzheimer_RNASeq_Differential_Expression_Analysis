# 05_deseq2_analysis.R
# Alzheimer (AD) ve Kontrol ornekleri arasinda diferansiyel gen ifadesi (DESeq2).
# Calistirma: proje klasorunun icinden  Rscript scripts/05_deseq2_analysis.R

library(DESeq2)

# 1. Sayim tablosunu oku (# ile baslayan satir yorumdur, atlanir)
counts_raw <- read.delim("analysis/counts/all_samples_counts.txt",
                         comment.char = "#", row.names = 1, check.names = FALSE)

# Ilk 5 sutun gen bilgisi (Chr, Start, End, Strand, Length), sayimlar 6. sutundan baslar
counts <- counts_raw[, 6:ncol(counts_raw)]
colnames(counts) <- sub("_sorted.bam", "", basename(colnames(counts)))

# 2. Ornek bilgisini oku; Control referans grup olsun
coldata <- read.csv("data/metadata/samples.csv", row.names = "Sample_ID")
coldata$Group <- factor(coldata$Group, levels = c("Control", "AD"))
counts <- counts[, rownames(coldata)]

# 3. DESeq2 analizi (karsilastirma: AD vs Control)
dds <- DESeqDataSetFromMatrix(countData = counts, colData = coldata, design = ~ Group)
dds <- DESeq(dds)
res <- results(dds, contrast = c("Group", "AD", "Control"))

# 4. Sonucu kaydet
write.csv(as.data.frame(res), "results/differential_expression_results.csv")
