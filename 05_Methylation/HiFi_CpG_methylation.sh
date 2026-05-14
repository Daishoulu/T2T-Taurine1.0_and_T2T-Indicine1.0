#!/bin/sh
# ================================================
# PacBio CCS / HiFi DNA methylation analysis (CpG)
# Tools: pbmm2, samtools, pb-CpG-tools
# ================================================

# 1. Build index for reference genome using pbmm2
pbmm2 index genome.fasta genome.mmi

# 2. Align PacBio CCS reads to genome
pbmm2 align -j 20 \
            --preset CCS \
            --sample genome \
            --sort \
            --sort-memory 10G \
            genome.mmi pb_bam.fofn genome.sort.bam

# 3. Index sorted BAM for downstream tools
samtools index genome.sort.bam

# 4. Call CpG methylation scores using pb-CpG-tools
pb-CpG-tools-v2.3.2/bin/aligned_bam_to_cpg_scores \
    --bam genome.sort.bam \
    --min-mapq 0 \
    --model pb-CpG-tools-v2.3.2/models/pileup_calling_model.v1.tflite \
    --output-prefix genome \
    --threads 10
