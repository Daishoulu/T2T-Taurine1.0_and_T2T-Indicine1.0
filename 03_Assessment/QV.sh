#!/bin/sh
# ================================================
# Genome quality assessment using Merqury
# Tools: Meryl + Merqury
# ================================================

# 1. Count k-mers from sequencing reads using Meryl
meryl k=21 threads=10 memory=50g count output reads.meryl clean.R1.fastq.gz clean.R2.fastq.gz

# 2. Run Merqury to assess genome assembly quality
merqury-1.3/merqury.sh reads.meryl genome.fasta prefix