#!/bin/sh
# ================================================
# Genome error correction and quality assessment using CRAQ
# Tools: CRAQ (Correcting Reads and Assembly Quality)
# ================================================

perl bin/craq \
    -g genome.fasta \
    -sms hifi.sort.bam \
    -ngs ngs.sort.bam \
    -rw 1500 \
    -pl T \
    -D Output \
    -t 20
