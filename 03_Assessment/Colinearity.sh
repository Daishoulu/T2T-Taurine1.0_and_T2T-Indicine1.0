#!/bin/sh
# ================================================
# Synteny and Structural Rearrangement Analysis using SyRI
# ================================================

# 1. Align query genome to reference genome using minimap2
minimap2 -t 16 -x asm5 -c --eqx ref.fa query.fa > prefix.paf

# 2. Identify structural rearrangements using SyRI
syri -c prefix.paf -F P -r ref.fa -q query.fa

# 3. Visualize syntenic blocks and structural variations with plotsr
plotsr --sr syri.out --genomes genomes.txt -H 8 -W 5
