#!/bin/sh
prefix=$1 #(e.g., prefix: T2T-Taurine1.0, T2T-Indicine1.0 or ARS-UCD2.0)

# 1: Convert filtered SNP VCF to pairwise genetic distance matrix
~/software/VCF2Dis-1.55/bin/VCF2Dis \
  -InPut SNPs.${prefix}-geno0.1-maf0.05-ldprune.vcf \
  -OutPut SNPs.${prefix}-geno0.1-maf0.05-ldprune.mat

# 2: Build a phylogenetic tree from the distance matrix
~/software/FastME-master/bin/fastme \
  -i SNPs.${prefix}-geno0.1-maf0.05-ldprune.mat \
  -t 16 \
  -o SNPs.${prefix}-geno0.1-maf0.05-ldprune.nwk

# 3: Visualize the phylogenetic tree using iTOL
