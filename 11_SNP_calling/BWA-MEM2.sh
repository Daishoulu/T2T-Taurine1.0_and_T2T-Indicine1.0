#!/bin/sh
# =========================================
# bwa-mem2.sh
# Step 1: Align paired-end reads to the reference genome using BWA-MEM2
# =========================================
Reference=$1
Fq1=$2
Fq2=$3
SampleName=$4
OutputDir=$5
Threads=$6

mkdir -p ${OutputDir}

bwa-mem2 mem -t ${Threads} \c
  -R "@RG\tID:${SampleName}\tSM:${SampleName}\tLB:lib1\tPL:ILLUMINA\tPU:unit1" \
  ${Reference} ${Fq1} ${Fq2} \
  | samtools view -@ ${Threads} -bS - \
  | samtools sort -@ ${Threads} -n -o ${OutputDir}/${SampleName}.nameSort.bam -

# Fix mate information
samtools fixmate -m -@ ${Threads} ${OutputDir}/${SampleName}.nameSort.bam ${OutputDir}/${SampleName}.fixmate.bam

# Sort by genomic coordinates
samtools sort -@ ${Threads} -o ${OutputDir}/${SampleName}.positionsort.bam ${OutputDir}/${SampleName}.fixmate.bam

# Mark and remove duplicates
samtools markdup -@ ${Threads} -r ${OutputDir}/${SampleName}.positionsort.bam ${OutputDir}/${SampleName}.sort.dedup.bam

# Index the final deduplicated BAM
samtools index -@ ${Threads} ${OutputDir}/${SampleName}.sort.dedup.bam

# Clean up intermediate BAM files
rm ${OutputDir}/${SampleName}.nameSort.bam ${OutputDir}/${SampleName}.fixmate.bam ${OutputDir}/${SampleName}.positionsort.bam
