#!/bin/sh
# 1. GeMoMa Analysis
## Extract CDS sequences from reference
java -jar GeMoMa-1.8.jar CLI Extractor a=query.gff3 g=query_genome.fasta outdir=. r=true
## Align CDS to genome
mmseqs2/bin/mmseqs createdb genome.fasta zi1807.genome
mmseqs2/bin/mmseqs easy-search --format-output query,target,pident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits,empty,raw,nident,empty,empty,empty,qframe,tframe,qaln,taln,qlen,tlen --threads 3 cds-parts.fasta zi1807.genome mmseq.tsv tmp
## Predict genes using GeMoMa
java -Xmx200g -jar GeMoMa-1.8.jar CLI GeMoMa s=mmseq.tsv t=genome.fasta c=cds-parts.fasta e=1e-5 prefix=query a=assignment.tabular m=350000 p=6  tag=mRNA sort=true
java -Xmx50G -jar GeMoMa-1.8.jar CLI GAF t=mRNA f="evidence>0" predicted_annotation.gff
java -Xmx50G -jar GeMoMa-1.8.jar CLI AnnotationFinalizer g=genome.fasta a=filtered_predictions.gff rename=NO t=mRNA
sed -i 's/GAF/GeMoMa/g' final_annotation.gff
perl -ne '@a=split;if($a[2] eq "CDS"){if($a[8]=~/Parent=([^;]+)/){$a[8]="ID=$1;Target=$1";}print join("\t",@a),"\n";}' final_annotation.gff > GeMoMa.evm.gff3