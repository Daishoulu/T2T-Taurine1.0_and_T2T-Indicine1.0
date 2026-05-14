#!/bin/sh
fastaFile=$1
outDir=$2
results=$3
matrix=$4
genomeSize=$5
cpu=$6

mamba activate mashtree
mashtree --numcpus $cpu --outmatrix $matrix --file-of-files $fastaFile --genomesize $genomeSize --mindepth 0 --save-sketches $outDir > $results