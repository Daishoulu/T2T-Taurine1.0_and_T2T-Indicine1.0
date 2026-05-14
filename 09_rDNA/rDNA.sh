#!/bin/sh
# ================================================
# rRNA gene prediction using RNAmmer
# ================================================

rnammer -S euk -m lsu,ssu,tsu -gff genome.gff genome.fasta

# -S euk            : specify organism type, here eukaryotic
# -m lsu,ssu,tsu    : predict all three types of rRNA genes
#                     lsu = large subunit (28S/23S)
#                     ssu = small subunit (18S/16S)
#                     tsu = 5S rRNA
# -gff genome.gff   : output file in GFF format with predicted rRNA gene coordinates
# genome.fasta      : input genome assembly in FASTA format

# Output:
#   - genome.gff     : coordinates of predicted rRNA genes for downstream annotation
#   - optionally additional output files (e.g., rRNA sequences)