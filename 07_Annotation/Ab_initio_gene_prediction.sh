#!/bin/sh
# 1. Augustus Prediction
## Train Augustus using flanking regions
computeFlankingRegion.pl evidence.gff > flanking.log
flanking=`grep -P "The\sflanking_DNA\svalue\sis:" flanking.log | perl -ne 'chomp;@a=split/\:/;print "$a[1]\n";'`
gff2gbSmallDNA.pl evidence.gff genome.fasta $flanking bonafide.gb
etraining --species=zi1807 bonafide.gb
## Generate hints from NGS BAM
samtools sort -n Aligned.out.bam -o Aligned.out.ssn.bam
filterBam --uniq --in Aligned.out.ssn.bam --out Aligned.out.ssf.bam
samtools sort Aligned.out.ssf.bam -@ 5 -o Aligned.out.ssfs.bam
bam2hints --intronsonly --in=Aligned.out.ssfs.bam --out=introns.gff
filterIntronsFindStrand.pl genome.fasta introns.gff --score > hint.gff
## Predict genes with Augustus
augustus-3.3.1/scripts/autoAugPred.md.pl --continue --genome=genome.soft.masked.fasta --species=zi1807 --hints=hint.gff --extrinsiccfg=extrinsic.cfg
cd autoAugPred_hints/shells;
bash aug? aug??
cd ../../;
augustus-3.3.1/scripts/autoAugPred.md.pl --useexisting --continue --genome=genome.soft.masked.fasta --species=zi1807 --hints=hint.gff --extrinsiccfg=extrinsic.cfg
EVidenceModeler-1.1.1/EvmUtils/misc/augustus_GTF_to_EVM_GFF3.pl autoAugPred_hints/predictions/augustus.gtf > Augustus.gff3

# 2. Glimmer Analysis
## Predict genes using GlimmerHMM
GlimmerHMM_v3.0.4/bin/glimmerhmm_linux_x86_64 genome.soft.masked.fasta trained_dir_zi1807 -g > Glimmer.gff
EVidenceModeler-1.1.1/EvmUtils/misc/glimmerHMM_to_GFF3.pl Glimmer.gff > Glimmer.evm.gff