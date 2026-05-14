#!/bin/sh
# ================================================
# Genome polishing using HiFi + NGS reads
# Tools: minimap2, samtools, yak, NextPolish2
# ================================================

# 1. Map HiFi reads to assembly using minimap2
minimap2 --secondary=no -t 40 -ax map-hifi genome.fasta hifi.fq.gz | samtools sort -o aln.sort.bam

# 2. Index the sorted BAM file for downstream tools
samtools index aln.sort.bam


# 3. Count k-mers from NGS reads (k=21)
yak count -b37 -t 20 -k 21 -o k21.yak <(cat NGS.fastq) <(cat NGS.fastq)

# 4. Count k-mers from NGS reads (k=31)
yak count -b37 -t 20 -k 31 -o k31.yak <(cat NGS.fastq) <(cat NGS.fastq)

# 5. Run NextPolish2 for genome polishing
nextPolish2 aln.sort.bam genome.fasta k31.yak k21.yak -t 40 -o polish.fasta
