#!/bin/sh
# ================================================
# Telomere Identification
# Tools: TIDK, seqkit, bedtools, awk
# ================================================

# 1. Explore telomere repeat units using TIDK
tidk explore --minimum 5 --maximum 12 genome.fasta

# 2. Define left telomere repeat unit (canonical vertebrate: AACCCT)
telomere_left_unit=AACCCT
# Construct repeated pattern for searching (10 repeats)
left_pattern=`seq 1 10 | xargs -I{} echo -n $telomere_left_unit`

# 3. Locate left telomere repeats in genome
seqkit locate -m 0 -i -P -p $left_pattern genome.fasta -j 10 -o telomere.left.bed

# 4. Merge nearby left telomere hits into continuous regions
awk 'NR>1{print $1"\t"$5-1"\t"$6}' telomere.left.bed \
| bedtools sort -i - \
| bedtools merge -d 500 \
| awk '{print $1"\t"$2+1"\t"$3"\t"$3-$2}' > telomere.left.merge.bed

# 5. Define right telomere repeat unit (reverse complement of left)
telomere_right_unit=`echo $telomere_left_unit | tr a-z A-Z | tr ATCG TAGC | rev`

# Construct repeated pattern for right telomere
right_pattern=`seq 1 10 | xargs -I{} echo -n $telomere_right_unit`

# 6. Locate right telomere repeats in genome
seqkit locate -m 0 -i -P -p $right_pattern genome.fasta -j 10 -o telomere.right.bed

# 7. Merge nearby right telomere hits into continuous regions
awk 'NR>1{print $1"\t"$5-1"\t"$6}' telomere.right.bed \
| bedtools sort -i - \
| bedtools merge -d 500 \
| awk '{print $1"\t"$2+1"\t"$3"\t"$3-$2}' > telomere.right.merge.bed