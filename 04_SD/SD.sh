#!/bin/sh
# ================================================
# Segmental Duplication (SD) detection using BISER
# ================================================

# 1. Run BISER to detect SDs
biser -t 20 \
      --max-error 20 \
      --max-edit-error 10 \
      --output sd.biser.txt \
      --temp ./tmp \
      --gc-heap 3G \
      --kmer-size 21 \
      genome.soft.masked.fasta
