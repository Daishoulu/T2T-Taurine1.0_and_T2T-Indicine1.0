#!/bin/sh
# ================================================
# ONT DNA modification calling using modkit
# Tools: samtools, minimap2, modkit
# ================================================

# 1. Extract FASTQ from BAM and map ONT reads to reference genome
samtools fastq -@ 20 -T MM,ML ont_meth.bam \
| minimap2 -t 20 -ayx map-ont genome.fasta - \
| samtools view -@ 20 -b - \
| samtools sort -@ 20 - > genome.sort.bam

# 2. Index sorted BAM
samtools index -@ 20 genome.sort.bam
# Output: genome.sort.bam.bai, required for pileup

# 3. Index reference genome (FASTA)
samtools faidx genome.fasta

# 4. Call 5mC and 5hmC modifications at CG motif
modkit-0.4.1/target/release/modkit pileup genome.sort.bam mod.5mC_5hmC.bed \
    --ref genome.fasta \
    --motif CG 0 \
    --motif CHG 0 \
    --motif CHH 0 \
    -t 20

# 5. Call 6mA modifications at A motif
modkit-0.4.1/target/release/modkit pileup genome.sort.bam mod.6mA.bed \
    --ref genome.fasta \
    --motif A 0 \
    -t 20
