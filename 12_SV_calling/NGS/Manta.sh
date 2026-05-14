#!/bin/sh
BAM=$1
REF=$2
run_dir=$3
Threads=$4

~/software/manta-1.6.0.release_src/bin/configManta.py --bam $BAM --referenceFasta $REF --runDir $run_dir
$run_dir/runWorkflow.py -m local -j $Threads