#!/bin/sh
# =========================================
# GATK_SelectSNP.sh
# Step 5: Select only biallelic SNPs
# =========================================
Reference=$1
GenotypeGVCFsfile=$2
OutputDir=$3
Chrom=$4

mkdir -p $OutputDir

gatk SelectVariants \
    --java-options "-Xmx10g" \
    --reference ${Reference} \
    -V ${GenotypeGVCFsfile} \
    --select-type-to-include SNP \
    --restrict-alleles-to BIALLELIC \
    -O ${OutputDir}/Chr${Chrom}.called.snp.vcf.gz

