#!/bin/sh
SortBAM=$1
Reference=$2
SampleName=$3
Threads=$4

mkdir -p ${SampleName}
~/anaconda3/envs/cutesv/bin/cuteSV ${SortBAM} ${Reference} ${SampleName}.cuteSV.vcf ${SampleName} \
        --max_cluster_bias_INS 1000 \
        --diff_ratio_merging_INS 0.9 \
        --max_cluster_bias_DEL  1000 \
        --diff_ratio_merging_DEL 0.5 \
        --genotype --sample ${SampleName} --threads ${Threads} --min_mapq 20 --min_size 50 --max_size 100000

rm -rf ${SampleName}