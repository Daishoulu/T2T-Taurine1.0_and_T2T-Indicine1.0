#!/bin/sh
# ================================================
# Pore-C data processing and HapHic scaffolding
# ================================================

# 1. Map Pore-C reads to reference genome using minimap2
minimap2 -x map-ont -B 3 -O 2 -E 5 -k13 -a -t 20 genome.fasta PoreC.fastq -o PoreC.sam

# 2. Convert SAM to BAM and index for downstream processing
samtools view --threads 20 -b PoreC.sam -o PoreC.bam

# 3. Prepare paired-end BAM for HapHic using Python script
python3 prepare_paired_bam_minimap2.py PoreC.bam --mapq 1 porec_paired.bam

# 4. Scaffolding using HapHic
haphic pipeline genome.fasta porec_paired.bam chr_number --threads 32 --processes 32
