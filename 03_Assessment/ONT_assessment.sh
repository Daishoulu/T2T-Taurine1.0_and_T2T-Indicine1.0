#!/bin/sh
# ================================================
# Genome coverage analysis for ONT 
# Tools: minimap2, samtools, pandepth
# ================================================

# 2. ONT reads
minimap2 --secondary=no -t 10 -ax map-ont genome.fasta ont.fastq.gz \
| samtools view --threads 8 -T genome.fasta -bS \
| samtools sort --threads 10 -o ont.sort.bam

samtools index -@ 20 ont.sort.bam

pandepth -t 20 -q 0 -w 100000 -i ont.sort.bam -o ont

zcat ont.win.stat.gz | grep -v "#" | awk '{print $1"\t"$2"\t"$3"\t"$8}' > ontregion.bed
