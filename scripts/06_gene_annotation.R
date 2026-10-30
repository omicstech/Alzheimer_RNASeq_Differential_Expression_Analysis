# 06_gene_annotation.R
# Ensembl gen kodlarina gen sembollerini ekler, sonra en anlamli 20 geni yazar.
# Calistirma: proje klasorunun icinden  Rscript scripts/06_gene_annotation.R

library(AnnotationDbi)
library(org.Hs.eg.db)

# 1. 05'in urettigi sonuc tablosunu oku
res <- read.csv("results/differential_expression_results.csv", row.names = 1)

# 2. Once gen sembollerini ekle (bulunamayanlar NA kalir)
res$symbol <- mapIds(org.Hs.eg.db, keys = rownames(res),
                     column = "SYMBOL", keytype = "ENSEMBL", multiVals = "first")
write.csv(res, "results/DEGs_with_gene_symbols.csv")

# 3. Sonra en kucuk padj'li ilk 20 geni yaz (artik sembol sutunu var)
top20 <- res[order(res$padj), ][1:20, ]
write.csv(top20, "results/Top20_DEGs.csv")
