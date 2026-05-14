#!/bin/bash
# =========================================
# Step 1: Align paired-end reads to the reference genome using BWA-MEM2
# =========================================
Reference=$1
Fq1=$2
Fq2=$3
SampleName=$4
OutputDir=$5
Threads=$6

mkdir -p ${OutputDir}

bwa-mem2 mem -t ${Threads} \
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


# =========================================
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


# =========================================
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


# =========================================
# Step 4: Genotype combined GVCFs
# =========================================
Reference=$1
InputDir=$2
OutputDir=$3
Chr=$4

gatk GenotypeGVCFs -R ${Reference} \
    -V ${InputDir}/Chr${Chr}.merged.g.vcf.gz \
    -O ${OutputDir}/Chr${Chr}.called.vcf.gz


# =========================================
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


# =========================================
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


# =========================================
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