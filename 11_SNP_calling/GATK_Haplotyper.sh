#!/bin/sh
# =========================================
# GATK_Haplotyper.sh
# Step 2: Call variants per sample using GATK HaplotypeCaller in GVCF mode
# =========================================
Reference=$1
SampleName=$2
ChromName=$3
Threads=$4
OutputDir=$5
tmpDir=$6

mkdir -p $tmpDir

gatk --java-options "-Xmx8g -XX:ParallelGCThreads=${Threads}" HaplotypeCaller \
    -R ${Reference} \
    -I ${SampleName}.sort.dedup.bam \
    -O ${OutputDir}/${SampleName}.${ChromName}.g.vcf.gz \
    -L ${ChromName} \
    -ERC GVCF \
    --native-pair-hmm-threads ${Threads} \
    --tmp-dir $tmpDir

rm -rf $tmpDir