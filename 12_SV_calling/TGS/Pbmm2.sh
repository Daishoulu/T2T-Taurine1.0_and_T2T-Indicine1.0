#!/bin/sh
Reference=$1
HiFi=$2
SampleName=$3

~/anaconda3/envs/pbmm2/bin/pbmm2 align ${Reference} ${HiFi} ${SampleName}.sort.bam --sort --preset HiFi --sample ${SampleName} --rg "@RG\tID:${SampleName}\tSM:${SampleName}"
samtools index ${SampleName}.sort.bam