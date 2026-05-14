#!/bin/sh
# ==================================================================================
# Calculate pairwise linkage disequilibrium (LD, r²) for SNPs within ±1 Mb of each structural variant (SV) using PLINK
# ==================================================================================

for svSplitList in `ls svSplit/sv_*`; do
    basename=$(echo ${svSplitList} | cut -f 2 -d "/")
    ~/software/plink/plink \
        --bfile SNPs_SVs.maf0.01.geno0.1.Angus_T2T \
        --maf 0.01 \
        --allow-extra-chr \
        --keep-allele-order \
        --double-id \
        --chr-set 29 \
        --r2 \
        --keep taurine_and_indicine.list \
        --ld-snp-list ${svSplitList} \
        --ld-window-kb 1000 \
        --ld-window 99999 \
        --ld-window-r2 0 \
        --out LDresults/${basename}.maf0.01.geno0.1
done