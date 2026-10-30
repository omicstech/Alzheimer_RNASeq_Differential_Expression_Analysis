#!/bin/bash
# 04_featureCounts.sh
# Gen bazinda okuma sayar (featureCounts) ve BAM dosyalarini CRAM'e cevirir.
# Calistirma: proje klasorunun icinden  bash scripts/04_featureCounts.sh

GTF=data/reference/Homo_sapiens.GRCh38.110.gtf
GENOME=data/reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa

mkdir -p analysis/counts

featureCounts -T 4 -a $GTF -o analysis/counts/all_samples_counts.txt analysis/alignment/*_sorted.bam

for BAM in analysis/alignment/*_sorted.bam; do
  CRAM=${BAM%.bam}.cram
  samtools view -T $GENOME -C -@ 4 -o $CRAM $BAM
  samtools index $CRAM
done
