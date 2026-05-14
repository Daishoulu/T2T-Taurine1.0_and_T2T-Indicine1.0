#!/bin/sh
# 1. NGS Transcriptome-based Gene Prediction
## Clean NGS reads
fastp -i NGS.R1.fastq.gz -I NGS.R2.fastq.gz -o NGS.R1.clean.fq.gz -O NGS.R2.clean.fq.gz 
## STAR genome indexing and alignment
STAR --runMode genomeGenerate --genomeDir star_index --genomeFastaFiles genome.fasta --runThreadN 5
STAR --runThreadN 8 --genomeDir star_index --readFilesIn NGS.R1.clean.fq.gz NGS.R2.clean.fq.gz --readFilesCommand zcat --outWigType bedGraph --outSAMtype BAM SortedByCoordinate --outSAMstrandField intronMotif
## Merge BAM files
ls Aligned.sortedByCoord.out.bam > bam.fofn
samtools merge -@ 8 -b bam.fofn Aligned.out.bam
## Assemble transcripts with StringTie
stringtie-2.1.4.Linux_x86_64/stringtie -o stringtie.gtf -p 8 Aligned.out.bam



# 2. ONT Transcriptome-based Gene Prediction
## Extract full-length cDNA reads
zcat ont.fastq.gz | Chopper/v0.6.0/bin/chopper -q 7 -l 0 -t 20 | awk '{print $1}' > all_filt.fastq
Pychopper2/v2.5.0/bin/cdna_classifier.py -t 20 -m phmm -u unclassified.fastq -S cdna_classifier_report.tsv all_filt.fastq full_length.fastq
seqkit seq -m 100 full_length.fastq > full_length_filt.fastq
## Map full-length reads with minimap2 and sort BAM
minimap2 -t 20 -ax splice -uf genome.fasta full_length_filt.fastq | samtools sort -@ 20 -o full_length_filt.bam -
samtools view -@ 20 -q 40 -F 2304 -b full_length_filt.bam > only_primary.bam
samtools index only_primary.bam
## Assemble ONT transcripts using StringTie
stringtie-2.1.4.Linux_x86_64/stringtie -v -p 20 -L --rf --conservative -l ONT -o temp.gtf only_primary.bam
cat temp.gtf | grep -v '^#' | awk -F '\t' '$7 != "\."' > ont.transcripts.gtf