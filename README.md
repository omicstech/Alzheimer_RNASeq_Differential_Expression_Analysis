# Alzheimer RNA-seq: Diferansiyel Gen İfadesi Analizi

Fusiform girus (beyin dokusu) üzerinde Alzheimer hastası (AD) ve kontrol bireylerin RNA-seq verileriyle diferansiyel gen ifadesi analizi.

# Alzheimer RNA-seq: Differential Gene Expression Analysis

Differential gene expression analysis of RNA-seq data from the fusiform gyrus (brain tissue) of Alzheimer's disease (AD) patients and control individuals.

---

## Proje özeti / Project summary

| Özellik / Feature | Değer / Value |
|---|---|
| Organizma / Organism | Homo sapiens |
| Doku / Tissue | Fusiform girus / Fusiform gyrus |
| Referans genom / Reference genome | GRCh38, Ensembl 110 (primary assembly) |
| Veri kaynağı / Data source | NCBI SRA, BioProject PRJNA516886 |
| Örnek sayısı / Sample count | 8 (4 AD, 4 Control) |
| Okuma tipi / Read type | Tek uçlu / Single-end |
| Araçlar / Tools | SRA Toolkit, FastQC, HISAT2, samtools, featureCounts, DESeq2 |

## Örnekler / Samples

| Sample ID | Grup / Group | Yaş / Age | Cinsiyet / Sex |
|---|---|---|---|
| SRR8482664 | AD | 82 | Kadın / Female |
| SRR8482665 | AD | 77 | Kadın / Female |
| SRR8482727 | AD | 86 | Kadın / Female |
| SRR8482728 | AD | 86 | Kadın / Female |
| SRR8482739 | Control | 82 | Kadın / Female |
| SRR8482631 | Control | 78 | Kadın / Female |
| SRR8482734 | Control | 86 | Kadın / Female |
| SRR8482685 | Control | 85 | Kadın / Female |

AD örnekleri SRA kayıtlarında Alzheimer tanısıyla işaretlidir. Kontroller, aynı projedeki kontrol örneklerinden yaş ve cinsiyete göre eşleştirilerek seçildi. RIN (RNA kalitesi) ve ölüm sonrası süre bilgisi mevcut değil.

AD samples are labeled with an Alzheimer diagnosis in the SRA records. Controls were matched from the same project by age and sex. RIN (RNA quality) and post-mortem interval are not available.

## Klasör yapısı / Folder structure

- `analysis/alignment/`: Hizalama çıktıları (sıralı BAM dosyaları, hizalama özetleri). Büyük olduğu için Git'e eklenmez. / Alignment outputs (sorted BAM, summaries). Not tracked by Git (large).
- `analysis/counts/`: featureCounts çıktısı / featureCounts output.
- `analysis/qc/`: FastQC raporları / FastQC reports.
- `data/metadata/`: Örnek bilgisi (`samples.csv`) / Sample metadata.
- `data/raw_fastq/`: Ham FASTQ dosyaları, Git'e eklenmez, `01_download_data.sh` ile indirilir / Raw FASTQ, not tracked, re-downloaded by script 01.
- `data/reference/`: Genom, GTF ve HISAT2 index, Git'e eklenmez / Genome, GTF and HISAT2 index, not tracked.
- `figures/`: Grafikler, açıklaması `figures/README.md` dosyasında / Figures, described in `figures/README.md`.
- `results/`: DESeq2 sonuçları ve sembollü tablolar / DESeq2 results and annotated tables.
- `scripts/`: Pipeline scriptleri (01-08) / Pipeline scripts (01-08).

## Pipeline adımları / Pipeline steps

1. **Veri indirme / Data download:** `scripts/01_download_data.sh` (prefetch, fasterq-dump)
2. **Kalite kontrol / Quality control:** `scripts/02_fastqc.sh` (FastQC)
3. **Hizalama / Alignment:** `scripts/03_hisat2_alignment.sh` (HISAT2, samtools)
4. **Sayım / Counting:** `scripts/04_featureCounts.sh` (featureCounts, gen düzeyi / gene level)
5. **Diferansiyel ifade / Differential expression:** `scripts/05_deseq2_analysis.R` (DESeq2, referans grup / reference group: Control)
6. **Gen anotasyonu / Gene annotation:** `scripts/06_gene_annotation.R` (gen sembolleri ve en anlamlı 20 gen / gene symbols and top 20 genes)
7. **Görselleştirme / Visualization:** `scripts/07_visualizations.R` (volcano, MA, barplot)
8. **PCA ve ısı haritası / PCA and heatmap:** `scripts/08_pca_heatmap.R`

## Sonuçlar / Results

- `results/differential_expression_results.csv`: Tüm genlerin DESeq2 sonuçları (62.754 gen) / All genes (62,754).
- `results/DEGs_with_gene_symbols.csv`: Aynı tablo, gen sembolleriyle / Same table with gene symbols.
- `results/Top20_DEGs.csv`: En anlamlı 20 gen (padj'e göre) / Top 20 genes by padj.
- `figures/`: Grafikler / Figures.

Özet / Summary: padj < 0,05 olan 59 gen bulundu. 49'u AD'de yüksek, 10'u Control'de yüksek. / 59 genes with padj < 0.05: 49 higher in AD, 10 higher in Control.

## Gereksinimler / Requirements

- SRA Toolkit 3.4.1 (`prefetch`, `fasterq-dump`)
- FastQC 0.12.1
- HISAT2 2.2.2 (`hisat2`, `hisat2-build`)
- samtools 1.23.1
- Subread featureCounts 2.0.8
- R ve paketleri / R and packages: DESeq2, AnnotationDbi, org.Hs.eg.db (3.22.0), ggplot2, pheatmap, RColorBrewer

## Yöntem notları ve sınırlılıklar / Method notes and limitations

- **Trimming yapılmadı / No trimming:** Adaptör oranı düşük (yaklaşık %1-4), kalite kontrolleri geçti, hizalama oranı %94-96. / Adapter content low (about 1-4%), quality checks passed, alignment rate 94-96%.
- **Küçük örneklem / Small sample:** 4'e 4 karşılaştırma. Sonuçlar ilk bulgu olarak okunmalı. / 4 vs 4 comparison. Results should be read as preliminary findings.
- **Kontrol eşleştirmesi / Control matching:** Yaş ve cinsiyete göre. RIN, ölüm sonrası süre ve işleme grubu bilinmiyor. / By age and sex. RIN, post-mortem interval and batch unknown.
- **Gen düzeyinde sayım / Gene-level counting:** İzoform düzeyinde analiz yapılmadı. / No isoform-level analysis.
- **Eski dosyalar / Old files:** `analysis/qc/` içindeki `_1` uzantılı raporlar ve Temmuz tarihli CRAM dosyaları önceki (yanlış etiketli) analizden kalmadır, geçerli değildir. / Files with `_1` in analysis/qc and July CRAM files come from an earlier analysis with wrong labels and are not valid.

## Yeniden üretme / Reproduction

Scriptleri 01'den 08'e sırayla çalıştır. HISAT2 index kurulumu (03) yaklaşık 12 dakika, 8 örneğin hizalaması yaklaşık 1 saat sürdü. / Run scripts 01 to 08 in order. HISAT2 index build took about 12 minutes; alignment of all samples about 1 hour.