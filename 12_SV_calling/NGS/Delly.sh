#!/bin/sh
Reference=$1
BAM=$2
SampleName=$3

Delly call -g $Reference -o ${SampleName}.bcf -q 20 $BAM
BCFtools view ${SampleName}.bcf > ${SampleName}.vcf
rm ${SampleName}.bcf ${SampleName}.bcf.csi