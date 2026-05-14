#!/bin/sh
REF=$1
workDir=$2
cactus-pangenome ./temp_jobstore ./Bos_dist.txt \
        --outDir Bos-pg --outName Bos-pg --reference $REF --vcfReference $REF --vcf --giraffe --gfa --gbz \
        --maxDisk 50000G --maxMemory 1000G --maxCores 88 --mgCores 88 --mapCores 88 --consCores 88 --consMemory 1000G --indexCores 88 --indexMemory 1000G \
        --workDir $workDir