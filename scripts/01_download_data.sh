#!/bin/bash
# 01_download_data.sh
# SRA'dan FASTQ dosyalarini indirir.
# Calistirma: proje klasorunun icinden  bash scripts/01_download_data.sh

mkdir -p data/raw_fastq

while read SRR; do
  if [ ! -s data/raw_fastq/${SRR}.fastq ]; then
    prefetch $SRR -O data/raw_fastq
    fasterq-dump data/raw_fastq/$SRR -O data/raw_fastq
  fi
done < data/SRR_accessions.txt
