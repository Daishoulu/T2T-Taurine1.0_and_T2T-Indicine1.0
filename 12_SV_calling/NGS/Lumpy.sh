#!/bin/sh
BAM=$1
SampleName=$2

samtools view -b -F 1294 $BAM > ${SampleName}.discordants.bam
samtools view -h $BAM | extractSplitReads_BwaMem -i stdin | samtools view -Sb - > ${SampleName}.splitters.bam
lumpyexpress \
    -B $BAM \
    -S ${SampleName}.splitters.bam \
    -D ${SampleName}.discordants.bam \
    -o ${SampleName}.lumpy.vcf
rm ${SampleName}.splitters.bam ${SampleName}.discordants.bam