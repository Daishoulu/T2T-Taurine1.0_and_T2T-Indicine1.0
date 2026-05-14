#!/bin/sh
# ==============================================================
# Merge per-sample SURVIVOR SVs into a prefixulation-level VCF
# ==============================================================

prefix=$1
SAMPLE_LIST=$2
OUTBASE=$3

# Create output directory for prefixulation-level merged SVs
prefix_DIR="${OUTBASE}/${prefix}"
MERGE_DIR="${prefix_DIR}/merge_diffSample"
mkdir -p ${MERGE_DIR}
cd ${prefix_DIR} || exit 1

# Create or clear the sample list file
> diffSample.list

# prefixulate the file with paths to per-sample merged SV VCFs
while read SAMPLE; do
    echo "${prefix_DIR}/merge_diffCaller/${SAMPLE}.diffCaller.merged.vcf" >> diffSample.list
done < ${SAMPLE_LIST}

~/software/SURVIVOR-master/Debug/SURVIVOR merge diffSample.list 1000 2 1 0 0 50 ${MERGE_DIR}/NGS.vcf
