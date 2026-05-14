#!/bin/sh
# =========================================
# Run ADMIXTURE for population structure analysis
# =========================================
BED=$1 #input PLINK .bed file
K=$2
prefix=$3 #(e.g., T2T-Taurine1.0, T2T-Indicine1.0, or ARS-UCD2.0)
Threads=$4

admixture --cv ${BED} -j${Threads} $K | tee ${prefix}.${K}.out