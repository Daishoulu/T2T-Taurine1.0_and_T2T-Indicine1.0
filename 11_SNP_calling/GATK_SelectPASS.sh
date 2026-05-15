#!/bin/sh
# =========================================
# GATK_SelectPASS.sh
# Step 7: Select passing SNPs only
# =========================================
VCF=$1
OutputDir=$2
Chrom=$3

gatk SelectVariants \
    --java-options "-Xmx10g" \
    -V ${VCF} \
    --exclude-filtered \
    -O ${OutputDir}/Chr${Chrom}.snp.passed.vcf.gz