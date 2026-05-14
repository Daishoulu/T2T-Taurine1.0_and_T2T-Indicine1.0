#!/bin/sh
# ================================================
# Genome coverage analysis for NGS reads
# Tools: minimap2, samtools, pandepth
# ================================================

# 1. NGS (short reads)
minimap2 --secondary=no -t 20 -ax sr genome.fasta r1.fastq.gz r2.fastq.gz \
| samtools view --threads 10 -T genome.fasta -bS \
| samtools sort --threads 8 -m 4G -o ngs.sort.bam

samtools index -@ 20 ngs.sort.bam

pandepth -t 20 -q 0 -w 100000 -i ngs.sort.bam -o ngs

zcat ngs.win.stat.gz | grep -v "#" | awk '{print $1"\t"$2"\t"$3"\t"$8}' > ngsregion.bed