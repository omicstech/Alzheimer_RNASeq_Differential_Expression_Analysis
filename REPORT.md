# Alzheimer RNA-seq Analiz Raporu

## 1. Amaç

Fusiform girus dokusunda Alzheimer hastalığı (AD) ile kontrol bireyleri arasında diferansiyel gen ifadesini belirlemek.

Bu analiz, hastalığın beyin dokusunda hangi genleri etkilediğine dair bir ilk yanıt aramak için yapıldı. Sonuçlar, hastalık mekanizmasına ilişkin hipotez üretmeyi amaçlar.

**Bu çalışma neyi sağlar:**
- Hasta ve kontrol dokusu arasında gen ifadesi farkını ölçülebilir ve tekrarlanabilir hâle getirir.
- Hangi genlerin ve biyolojik süreçlerin daha ayrıntılı incelenmeye değer olduğunu gösterir.
- Aynı pipeline'ın daha büyük veri setlerinde kullanılabilmesi için doğrulanmış bir temel oluşturur.

**Bu çalışma neyi sağlamaz:**
- Genlerin hastalığa neden olduğunu kanıtlamaz.
- Tanı ya da tedavi için kullanılamaz.
- Genel AD popülasyonu hakkında genelleme yapmaz.

## 2. Veri

- **Kaynak:** NCBI SRA, BioProject PRJNA516886 (fusiform girus RNA ekspresyonu, AD ve kontrol bireyleri).
- **Örnekler:** 4 AD, 4 kontrol. Hepsi kadın, yaşları 77 ile 86 arasında.
- **Okuma tipi:** Tek uçlu (single-end), Illumina HiSeq 2500.
- **Grup tanımı:** AD örnekleri SRA kayıtlarındaki "Alzheimer hastalığı" tanısıyla doğrulandı. Kontroller aynı projeden, yaş ve cinsiyete göre eşleştirilerek seçildi.

| Örnek | Grup | Yaş |
|---|---|---|
| SRR8482664 | AD | 82 |
| SRR8482665 | AD | 77 |
| SRR8482727 | AD | 86 |
| SRR8482728 | AD | 86 |
| SRR8482739 | Kontrol | 82 |
| SRR8482631 | Kontrol | 78 |
| SRR8482734 | Kontrol | 86 |
| SRR8482685 | Kontrol | 85 |

## 3. Yöntem

1. **Veri indirme:** SRA Toolkit (`prefetch`, `fasterq-dump`) ile FASTQ dosyaları alındı.
2. **Kalite kontrol:** FastQC ile her örnek incelendi. Temel kalite ve adaptör kontrolleri geçildi. RNA-seq verisinde sık görülen aşırı temsil edilen dizi uyarıları mevcut.
3. **Kırpma kararı:** Adaptör oranı düşük (%1-4) ve hizalama oranı yüksek olduğu için kırpma (trimming) yapılmadı. Örnekler arası tutarlılık için ya hepsi ya hiçbiri kırpılacaktı.
4. **Hizalama:** HISAT2 2.2.2 ile GRCh38 genomuna (Ensembl 110, primary assembly) hizalandı, samtools ile sıralandı. Genel hizalama oranı %94-96.
5. **Sayım:** featureCounts 2.0.8 ile gen düzeyinde sayım yapıldı (Ensembl 110 GTF). Toplam 62.754 gen.
6. **Diferansiyel ifade:** DESeq2 ile tasarım `~ Group`, referans grup Kontrol. Düzeltilmiş p değeri (padj) Benjamini-Hochberg yöntemiyle hesaplandı.
7. **Anotasyon:** Ensembl kodları org.Hs.eg.db ile gen sembollerine çevrildi.
8. **Görselleştirme:** Volkan, MA ve barplot grafikleri (07), PCA ve ısı haritası (08) üretildi.

## 4. Sonuçlar

- **Anlamlı gen sayısı:** padj < 0,05 olan 59 gen.
- **Yön dağılımı:** 49 gen AD'de daha yüksek (log2FC > 0), 10 gen kontrolde daha yüksek (log2FC < 0).
- **İfade düzeyi:** Anlamlı genlerin medyan ortalama okuma sayısı (baseMean) 228. Hiçbiri 10'un altında değil.
- **Fark büyüklüğü:** 59 genin 56'sında |log2FC| > 1, yani en az 2 kat fark.
- **En anlamlı 20 gen:** `results/Top20_DEGs.csv` dosyasında, gen sembolleriyle. Bunların 18'i AD'de daha yüksek.
- **Örnek kümelenmesi:** PCA'da gruplar PC1 ekseninde ayrışıyor (AD ortalaması −21, kontrol ortalaması +21). PC1'in yaşla korelasyonu 0,14, kütüphane büyüklüğüyle 0,29. Yani bu iki faktör ayrışmayı büyük ölçüde açıklamıyor.

## 5. Yorum

Bulgular hipotez üretici niteliktedir. Anlamlı genlerin bir kısmı glia, damar ve stres yanıtıyla ilişkili olabilir, ancak bu bir ön değerlendirmedir ve literatürle sistematik olarak karşılaştırılmamıştır.

Klinik kullanım için bağımsız doğrulama ve uzman değerlendirmesi gerekir.

## 6. Sınırlılıklar

- **Örneklem büyüklüğü:** 4'e 4. Sonuçlar ilk bulgu olarak değerlendirilmeli, bağımsız bir veri setinde doğrulanması gerekir.
- **Teknik değişkenler:** RIN (RNA kalitesi), ölüm sonrası süre (PMI) ve işleme grubu veri setinde yok. PC1 ayrışmasının bir kısmı teknik kaynaklı olabilir.
- **Hücre bileşimi:** Doku bileşimindeki (nöron, glia oranı) farklar, bazı genlerin farklı çıkmasına yol açmış olabilir. Bu kontrol edilmedi.
- **Gen düzeyi analiz:** İzoform düzeyinde analiz yapılmadı.
- **Çoklu eşleşen okumalar:** featureCounts varsayılanına göre sayıma dahil edilmedi. Tek yere oturan okumaların oranı %75-87.

## 7. Sonraki adımlar

1. Sonuçları orijinal çalışmanın yayınlanmış gen listesiyle karşılaştırmak.
2. Bağımsız bir AD fusiform girus veri setinde aynı genleri test etmek.
3. Hücre bileşimini tahmin edip gen farklarıyla ilişkisini incelemek.
4. Teknik değişkenler (RIN, PMI) için ek veri bulmak.

## 8. Yeniden üretme

Scriptleri 01'den 08'e sırayla çalıştır. HISAT2 index kurulumu yaklaşık 12 dakika, 8 örneğin hizalaması yaklaşık 1 saat sürdü.