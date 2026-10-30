#!/bin/bash
# 03_hisat2_alignment.sh
# Okumalari GRCh38 genomuna hizalar (HISAT2) ve siralanmis BAM uretir.
# Calistirma: proje klasorunun icinden  bash scripts/03_hisat2_alignment.sh

set -e   # herhangi bir komut hata verirse script durur

GENOME=data/reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa
INDEX=data/reference/GRCh38_index

mkdir -p analysis/alignment

# Index yoksa once kur (uzun surer)
if [ ! -f ${INDEX}.1.ht2 ]; then
  hisat2-build -p 4 $GENOME $INDEX
fi

while read SRR; do
  hisat2 -p 4 -x $INDEX -U data/raw_fastq/${SRR}.fastq -S analysis/alignment/${SRR}.sam --summary-file analysis/alignment/${SRR}_summary.txt
  samtools view -bS analysis/alignment/${SRR}.sam > analysis/alignment/${SRR}.bam
  samtools sort -o analysis/alignment/${SRR}_sorted.bam analysis/alignment/${SRR}.bam
  rm analysis/alignment/${SRR}.sam analysis/alignment/${SRR}.bam
done < data/SRR_accessions.txt
