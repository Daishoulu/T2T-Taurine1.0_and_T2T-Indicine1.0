#!/bin/sh
VCF=$1
Pop1=$2
Pop2=$3
prefix=$4 #(e.g., T2T-Taurine1.0, T2T-Indicine1.0, or ARS-UCD2.0)

vcftools --gzvcf $VCF \
        --weir-fst-pop $Pop1.list \
    --weir-fst-pop $Pop2.list \
        --fst-window-size 50000 \
        --fst-window-step 20000 \
        --out ${Pop1}_${Pop2}.${prefix}