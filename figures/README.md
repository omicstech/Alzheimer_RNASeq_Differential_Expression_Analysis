# Şekiller (figures)

Bu klasördeki grafikler 8 örnekle yapılan analizden üretildi: 4 AD (Alzheimer hastası) ve 4 Control. Sonuçlar DESeq2 ile hesaplandı (scripts/05_deseq2_analysis.R), grafikler scripts/07_visualizations.R ve scripts/08_pca_heatmap.R ile çizildi.

## Ortak eşikler ve okuma kuralları

- **Anlamlılık:** padj < 0,05 (Benjamini-Hochberg düzeltmesi ile). padj, çok sayıda gen test edildiği için şansa bağlı yanlış pozitifleri düzelten değerdir.
- **Fark büyüklüğü:** |log2FC| > 1, yani yaklaşık 2 kat fark.
- **Yön:** log2FC pozitifse gen AD'de daha yüksek, negatifse Control'de daha yüksek. Referans grup Control'dür.

## Volcano_Plot.png

- **Ne gösterir:** Her nokta bir gen. Yatay eksen log2FC (farkın büyüklüğü ve yönü), dikey eksen -log10(padj) (kanıtın gücü; yukarı çıktıkça daha anlamlı).
- **Renkler:** Kırmızı = AD'de yüksek ve anlamlı (49 gen). Mavi = Control'de yüksek ve anlamlı (10 gen). Gri = anlamlı değil.
- **Çizgiler:** Dikey kesikli çizgiler log2FC = ±1. Yatay kesikli çizgi 1,3, yani padj = 0,05'in -log10 değeri.
- **Araç:** R ggplot2 paketi.

## ma_plot.png

- **Ne gösterir:** Yatay eksen genin ortalama ifadesi (log10 baseMean), dikey eksen log2FC. Her nokta bir gen.
- **Okuma:** Nokta bulutu 0 çizgisi etrafında dengeli olmalı. Düşük ifadeli genlerde yayılım daha büyük olur, bu normaldir. Yorum için yüksek ifadeli anlamlı genlere bakılır.
- **Araç:** R ggplot2 paketi.

## PCA.png

- **Ne gösterir:** Örneklerin genel benzerliği. Her nokta bir örnek. Analizde tüm genler değil, en çok değişen 500 gen kullanıldı.
- **Okuma:** Aynı gruptaki örnekler yakın duruyorsa gruplar arası fark tutarlıdır. Eksen yüzdeleri (PC1, PC2) o eksenin toplam değişimin ne kadarını açıkladığını gösterir.
- **Dikkat:** Ayrışma hastalıktan gelebileceği gibi teknik farklardan da gelebilir. Bu grafik tek başına bunu ayırt etmez.
- **Araç:** DESeq2 (varyans dönüşümü) ve ggplot2.

## Heatmap.png

- **Ne gösterir:** En anlamlı 20 gen (en küçük padj) ve 8 örnek. Her hücrenin rengi, o genin ortalamasına göre ne kadar yüksek ya da düşük olduğunu gösterir. Kırmızı = ortalamanın üstünde, mavi = altında.
- **Üstteki çubuk:** Örneğin grubu (AD ya da Control).
- **Üstteki dal yapısı (dendrogram):** Örneklerin birbirine benzerliğini gösterir.
- **Okuma:** Aynı grubun örnekleri yan yana benzer renkte ve aynı dalda olmalı.
- **Araç:** pheatmap (R paketi).

## top_genes_barplot.png

- **Ne gösterir:** Anlamlı genler arasından log2FC'ye göre en yüksek 10 gen (AD'de yüksek, yukarı) ve en düşük 10 gen (Control'de yüksek, aşağı). Anlamlı genlerin toplamı 59, aşağı yönlü olan 10 gen tamamı gösterilir.
- **Araç:** R ggplot2 paketi.

## Yöntem notu

Bu sonuçlar, 4'e 4 küçük bir örneklemle elde edildi. Sonuçlar bir ilk bulgu olarak okunmalı, kesin biyolojik kanıt olarak değil.
