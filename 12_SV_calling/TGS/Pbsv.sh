#!/bin/sh
SortBAM=$1
Reference=$2
SampleName=$3

# 1. Discover signatures of structural variation
~/anaconda3/envs/pbsv/bin/pbsv discover ${SampleName}.sort.bam ${SampleName}.svsig.gz
# 2. Call structural variants and assign genotypes
~/anaconda3/envs/pbsv/bin/pbsv call --ccs -m 50 ${Reference} ${SampleName}.svsig.gz ${SampleName}.pbsv.vcf