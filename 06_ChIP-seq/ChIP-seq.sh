#!/bin/sh
# ================================================
# ChIP-seq analysis workflow
# Tools: fastp BWA MACS3/SICER2 DeepTools
# ================================================


# 1. Quality control and clean reads
fastp -i INPUT.R1.fastq.gz -I INPUT.R2.fastq.gz \
      -o INPUT.R1.clean.fq.gz -O INPUT.R2.clean.fq.gz \
      -n 0 -w 16

fastp -i CENP.R1.fastq.gz -I CENP.R2.fastq.gz \
      -o CENP.R1.clean.fq.gz -O CENP.R2.clean.fq.gz \
      -n 0 -w 16

# 2. Align reads to genome using BWA
bwa index -a bwtsw genome.fasta

bwa mem -t 8 genome INPUT.R1.clean.fq.gz INPUT.R2.clean.fq.gz \
| samtools view --threads 8 -bS \
| samtools sort -@ 8 -o INPUT.sort.bam
samtools index INPUT.sort.bam

bwa mem -t 8 genome CENP.R1.clean.fq.gz CENP.R2.clean.fq.gz \
| samtools view --threads 8 -bS \
| samtools sort -@ 8 -o CENP.sort.bam
samtools index CENP.sort.bam

# 3. Peak calling with MACS3
genome_size=`seqkit stat genome.fasta | awk 'NR==2' | awk '{print $5}' | sed 's/,//g'`

macs3 callpeak -t CENP.sort.bam -c INPUT.sort.bam \
               --broad -g ${genome_size} \
               -f BAM --broad-cutoff 0.1 -n prefix


grep -v "#" prefix_peaks.xls | sed '/^$/d' > prefix_peaks.bed

# 4. Peak calling with SICER2 (alternative)
sicer2 --cpu 16 -t CENP.sort.bam -c INPUT.sort.bam -s prefix

awk '$8 < 0.01 && $4>$5{print $1"\t"$2"\t"$3"\t"$4-$5}' prefix.*-islands-summary > prefix.peaks.01.bed

# 5. Signal visualization with DeepTools
deeptools -b1 CENP.sort.bam -b2 INPUT.sort.bam \
          --scaleFactorsMethod readCount \
          --operation log2 \
          --outFileName prefix.log2ratio.bedgraph \
          --binSize 1 \
          --numberOfProcessors 20 \
          --operation ratio \
          --outFileFormat bedgraph
