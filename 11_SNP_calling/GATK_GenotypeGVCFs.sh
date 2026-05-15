#!/bin/sh
# =========================================
# GATK_GenotypeGVCFs.sh
# Step 4: Genotype combined GVCFs
# =========================================
Reference=$1
InputDir=$2
OutputDir=$3
Chr=$4

gatk GenotypeGVCFs -R ${Reference} \
    -V ${InputDir}/Chr${Chr}.merged.g.vcf.gz \
    -O ${OutputDir}/Chr${Chr}.called.vcf.gz
