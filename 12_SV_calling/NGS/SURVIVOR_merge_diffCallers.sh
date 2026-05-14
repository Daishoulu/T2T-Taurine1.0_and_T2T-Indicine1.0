#!/bin/bash
# =====================================================================
# Merge structural variants (SVs) from multiple callers using SURVIVOR
# =====================================================================

prefix=$1
SAMPLE_LIST=$2
OUTBASE=$3

DEL_DIR="NGS/${prefix}/delly"
LUMPY_DIR="NGS/${prefix}/lumpy"
MANTA_DIR="NGS/${prefix}/manta"
BREAKDANCER_DIR="NGS/${prefix}/breakdancer"

# Create output directory for merged SVs
MERGE_DIR="${OUTBASE}/${prefix}/merge_diffCaller"
mkdir -p ${MERGE_DIR}
cd ${MERGE_DIR} || exit 1

# Loop over all samples in the sample list
while read SAMPLE; do
    LIST_FILE="${SAMPLE}.list"
    echo "${DEL_DIR}/${SAMPLE}.vcf" > ${LIST_FILE}
    echo "${LUMPY_DIR}/${SAMPLE}.lumpy.vcf" >> ${LIST_FILE}
    echo "${MANTA_DIR}/${SAMPLE}/results/variants/${SAMPLE}.diploidSV.vcf" >> ${LIST_FILE}
    echo "${BREAKDANCER_DIR}/${SAMPLE}.vcf" >> ${LIST_FILE}
    MERGED_VCF="${SAMPLE}.diffCaller.merged.vcf"
    ~/software/SURVIVOR-master/Debug/SURVIVOR merge ${LIST_FILE} 500 3 1 0 0 50 ${MERGED_VCF}
done < ${SAMPLE_LIST}

echo "SURVIVOR merging complete for: ${prefix}"