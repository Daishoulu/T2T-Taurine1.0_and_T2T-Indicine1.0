#!/bin/sh
# =========================================
# GATK_VariantFiltration.sh
# Step 6: Apply hard filters to SNPs
# =========================================
Reference=$1
GenotypeGVCFsfile=$2
OutputDir=$3
Chrom=$4

gatk VariantFiltration \
    --java-options "-Xmx10g" \
    --reference ${Reference} \
    -V ${GenotypeGVCFsfile} \
    --filter-expression "(QD < 2.0 || MQ < 40.0 || FS > 60.0 || SOR > 3.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0)" \
    --filter-name "SNPFilter" \
    -O ${OutputDir}/Chr${Chrom}.snp.filter.vcf.gz