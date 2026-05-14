#!/bin/sh
# ================================================
# Genome coverage analysis for HiFi, ONT, and NGS reads
# Tools: minimap2, samtools, pandepth
# ================================================

# 1. HiFi reads
minimap2 --secondary=no -t 10 -ax map-hifi genome.fasta hifi.fastq.gz \
| samtools view --threads 10 -T genome.fasta -bS \
| samtools sort --threads 10 -m 3G -o hifi.sort.bam

samtools index -@ 20 hifi.sort.bam

pandepth -t 20 -q 0 -w 100000 -i hifi.sort.bam -o hifi

zcat hifi.win.stat.gz | grep -v "#" | awk '{print $1"\t"$2"\t"$3"\t"$8}' > hifiregion.bed
