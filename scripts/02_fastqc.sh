#!/bin/bash
# 02_fastqc.sh
# Ham FASTQ dosyalarinin kalite kontrolunu yapar.
# Calistirma: proje klasorunun icinden  bash scripts/02_fastqc.sh

mkdir -p analysis/qc

while read SRR; do
  fastqc data/raw_fastq/${SRR}.fastq -o analysis/qc
done < data/SRR_accessions.txt
