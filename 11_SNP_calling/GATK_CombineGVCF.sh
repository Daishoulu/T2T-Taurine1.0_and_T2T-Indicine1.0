#!/bin/sh
# =========================================
# GATK_CombineGVCF.sh
# Step 3: Combine per-sample GVCFs per chromosome
# =========================================
Reference=$1
InputDir=$2
OutputDir=$3
SampleList=$4
Chr=$5
Threads=$6

gatk CombineGVCFs --java-options "-Xmx64g -XX:ParallelGCThreads=${Threads}" \
  -R ${Reference} \
  $(for s in `cat ${SampleList}`; do echo "--variant ${InputDir}/${s}.${Chr}.g.vcf.gz "; done) \
  -O ${OutputDir}/${Chr}.merged.g.vcf.gz