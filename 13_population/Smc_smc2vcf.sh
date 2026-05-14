#!/bin/sh
prefix=$1
ChromName=$2
output1=$3
output2=$4
smc++ vcf2smc SNPs.${prefix}.vcf.gz ${output1}/${ChromName}.smc.gz ${ChromName} Taurine:Sample1,Sample2
smc++ vcf2smc SNPs.${prefix}.vcf.gz ${output2}/${ChromName}.smc.gz ${ChromName} Indicine:Sample3,Sample4

