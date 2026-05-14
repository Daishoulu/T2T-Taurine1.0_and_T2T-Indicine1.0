#!/bin/sh
# ================================================
# Winnowmap mapping and extraction of purged/unique genomic regions
# Tools: winnowmap, samtools, bedtools
# ================================================

# 1. Align assembly to reference using Winnowmap
winnowmap -cx asm20 -H --MD assembly.fasta reference.fasta > out.paf

# 2. Index assembly FASTA for bedtools
samtools faidx assembly.fasta

# 3. Extract genome lengths for bedtools usage
cut -f 1,2 assembly.fasta.fai > genome.length.txt

# 4. Extract aligned regions and generate "purged" regions
cat out.paf \
| awk '{if ($12 > 0) print $6"\t"$8"\t"$9}' \
| bedtools sort -faidx genome.length.txt -i - \
| bedtools merge -i - \
| bedtools complement -i - -g genome.length.txt > genome.pur_region.txt
