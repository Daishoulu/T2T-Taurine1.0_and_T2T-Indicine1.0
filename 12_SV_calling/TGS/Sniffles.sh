#!/bin/sh
SortBAM=$1
SampleName=$2
~/anaconda3/envs/sniffles/bin/sniffles -i ${SampleName}.sort.bam -v ${SampleName}.sniffles.vcf --threads 16