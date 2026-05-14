#!/bin/sh
# 1. tRNAscan-SE Analysis
tRNAscan-SE --thread 4 -E -I -o zi1807.tRNA.tsv -f zi1807.tRNA.structure.txt genome.fasta -c tRNAscan-SE-master/tRNAscan-SE.conf

# 2. RNAmmer Analysis
rnammer -S euk -m lsu,ssu,tsu -gff zi1807.gff genome.fasta

# 3. Rfam Analysis
infernal/v1.1.4/bin/cmscan --cpu 4 -Z 6361.56872 --cut_ga --rfam --nohmmonly --fmt 2 --clanin Rfam/14.0/Rfam.clanin \
 --tblout zi1807.rfam.tsv Rfam/14.0/Rfam.cm genome.fasta > zi1807.cmscan