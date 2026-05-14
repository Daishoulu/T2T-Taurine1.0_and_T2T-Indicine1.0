#!/bin/sh
# 1. PASA Transcriptome Integration
# Prepare cleaned transcript sequences
gffread -w ngs_transcript.fasta -g genome.fasta stringtie.gtf
gffread -w ont_transcript.fasta -g genome.fasta ont.transcripts.gtf
seqclean-x86_64/seqclean ngs_transcript.fasta -c 5 -v seqclean-x86_64/UniVec_Core.fasta,seqclean-x86_64/UniVec.fasta
seqclean-x86_64/seqclean ont_transcript.fasta -c 5 -v seqclean-x86_64/UniVec_Core.fasta,seqclean-x86_64/UniVec.fasta
cat ont_transcript.fasta.clean | grep '>'|sed 's/>//g'|awk '{print $1}' > fl.acc
cat ngs_transcript.fasta ont_transcript.fasta > transcript.rename.fasta
cat ngs_transcript.fasta.clean ont_transcript.fasta.clean > transcript.rename.fasta.clean

# Run PASA to predict genes using transcript evidence
Launch_PASA_pipeline.pl -c PASA.alignAssembly.config --PASACONF pasa_conf/conf.txt  -C -R -g genome.fasta -T -u transcript.rename.fasta \
 -t transcript.rename.fasta.clean -f fl.acc  --CPU 5 --ALIGNERS gmap