#!/bin/sh
ReferenceDict=$1
BAM=$2
output=$3
SampleName=$4

perl bam2cfg -q 20 -n 100000 -v 10 ${BAM} > ${output}/${SampleName}.cfg
breakdancerMax ${output}/${SampleName}.cfg > ${output}/${SampleName}.ctx
java -jar javrkit breakdancer2vcf -R ${ReferenceDict} -o ${output}/${SampleName}.vcf ${output}/${SampleName}.ctx
rm ${output}/${SampleName}.cfg ${output}/${SampleName}.ctx