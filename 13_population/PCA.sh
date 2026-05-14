#!/bin/sh
prefix=$1 #(e.g., prefix: T2T-Taurine1.0, T2T-Indicine1.0 or ARS-UCD2.0)
Threads=$2

~/software/plink/plink \
    --bfile SNPs.${prefix} \
    --allow-extra-chr \
    --keep-allele-order \
    --double-id \
    --chr-set 29 \
    --threads $Threads \
    --keep randomSamples.list \
    --geno 0.1 \
    --maf 0.05 \
    --make-bed \
    --out SNPs.${prefix}-geno0.1-maf0.05-randomSamples
 
~/software/plink/plink \
    --bfile SNPs.${prefix}-geno0.1-maf0.05-randomSamples \
    --allow-extra-chr \
    --keep-allele-order \
    --double-id \
    --chr-set 29 \
    --threads $Threads \
    --indep-pairwise 50 5 0.2 \
    --out SNPs.${prefix}-geno0.1-maf0.05-randomSamples-ldprune

~/software/plink/plink \
    --bfile SNPs.${prefix}-geno0.1-maf0.05-randomSamples \
    --allow-extra-chr \
    --keep-allele-order \
    --double-id \
    --chr-set 29 \
    --threads $Threads \
    --extract SNPs.${prefix}-geno0.1-maf0.05-randomSamples-ldprune.prune.in \
    --make-bed \
    --out SNPs.${prefix}-geno0.1-maf0.05-randomSamples-ldprune

~/software/plink/plink \
    --bfile SNPs.${prefix}-geno0.1-maf0.05-randomSamples-ldprune \
    --allow-extra-chr \
    --keep-allele-order \
    --double-id \
    --chr-set 29 \
    --threads $Threads \
    --pca \
    --out SNPs.${prefix}-geno0.1-maf0.05-randomSamples-ldprune.PCA

Rscript pca.R SNPs.${prefix}-geno0.1-maf0.05-randomSamples-ldprune.PCA.eigenval SNPs.${prefix}-geno0.1-maf0.05-randomSamples-ldprune.PCA.eigenvec classFile.txt SNP.${prefix}.randomSamples 1 2