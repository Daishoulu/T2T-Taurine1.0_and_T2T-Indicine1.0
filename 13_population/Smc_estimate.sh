#!/bin/sh
input_dir=$1
output_dir=$2

smc++ estimate -o ${output_dir} 1.26e-8 ${input_dir}/*.smc.gz