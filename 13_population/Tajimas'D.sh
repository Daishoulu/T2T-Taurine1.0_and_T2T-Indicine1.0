#!/bin/sh
VCF=$1
Keep=$2
Pop=$3
Win=$4
prefix=$5 #(e.g., T2T-Taurine1.0, T2T-Indicine1.0, or ARS-UCD2.0)

vcftools --gzvcf $VCF \
    --keep $Keep \
    --TajimaD $Win \
    --out ${prefix}.${Pop}.${Win}