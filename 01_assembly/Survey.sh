#!/bin/sh
# 1. qc
fastp -i R1.fastq.gz -I R2.fastq.gz \
      -o R1.clean.fq.gz -O R2.clean.fq.gz \
      -n 0 -f 5 -F 5 -t 5 -T 5

# 2. K-mer
/kmc/v3.2.4/kmc -k21 -t16 -m64 -ci1 -cs1000000 -fq -sm @ngs.fofn kmcdb tmp

# 3. histo
/kmc/v3.2.4/kmc_tools transform kmcdb histogram sample.histogram.txt -ci1 -cx1000000

# 4. genomescope
R/bin/Rscript /genomescope2.0/genomescope.R -i sample.histogram.txt -k 21 -o ./ -p 2 --typical_error 5