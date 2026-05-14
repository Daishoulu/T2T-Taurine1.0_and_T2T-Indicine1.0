#!/bin/sh
# ================================================
# Genome repeat analysis and SRF (Satellite Repeat Finder)
# Tools: TRF, RepeatMasker, bedtools, KMC, SRF, BLAST
# ================================================

# 1. Tandem Repeat Finder (TRF) to identify tandem repeats
trf genome.fasta 2 7 7 80 10 50 500 -f -d -h -l 20

# 2. RepeatMasker to identify transposable elements (TEs)
RepeatMasker -engine abblast -lib repeatmasker.lib chr.fasta \
             -nolow -no_is -html -gff -dir ./ -pa 8

# 3. Convert RepeatMasker GFF to BED
awk '{print $1"\t"$4-1"\t"$5}' chr.out.gff > chr.Repeatmask.bed

# 4. Generate genome windows and calculate TE density
samtools faidx chr.fasta > chr.length.txt

bedtools makewindows -g chr.length.txt -w 100000 -s 100000 > ref.bed

bedtools coverage -a ref.bed -b chr.Repeatmask.bed | cut -f 1-3,7 > chr.Repeatmask.density.txt

# 5. Select top 20% windows with highest TE density
linenumber=`wc -l chr.Repeatmask.density.txt | awk 'num=$1/5{printf "%d",num}'`
sort -k 4nr chr.Repeatmask.density.txt | head -n ${linenumber} \
| bedtools sort -i - | bedtools merge -d 500000 -i - > chr.highTE.bed

cat chr*.highTE.bed | sort -k 1,1 -k 2n,2 > genome.highTE.bed

# 6. Extract high TE sequences
bedtools getfasta -fi genome.fasta -bed genome.highTE.bed -fo highTE.fa

# 7. Count k-mers in high TE sequences
kmc -fm -k35 -t16 -ci200 -cs1000000 highTE.fa count.kmc tmp_dir

kmc_dump count.kmc count.txt

# 8. Run SRF to identify satellite repeats
srf -l 20 -p prefix count.txt > prefix.srf.fa

# 9. Create BLAST database for genome
makeblastdb -in genome.fasta -input_type fasta -dbtype nucl -title chr_db -out chr_db

# 10. BLAST SRF repeats against genome
blastn -db chr_db -query prefix.srf.fa -out srf.blastn.m6.txt -outfmt 6 -num_threads 20
