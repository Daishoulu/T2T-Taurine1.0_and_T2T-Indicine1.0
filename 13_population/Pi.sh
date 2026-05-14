#!/bin/sh
# =========================================
# Calculate nucleotide diversity (pi) for a subset of individuals using VCFtools
# =========================================
VCF=$1
Pop=$2
prefix=$3

vcftools --gzvcf $VCF \
        --keep $Pop.list \
        --window-pi 50000 \
        --window-pi-step 20000 \
        --out ${prefix}.${Pop}