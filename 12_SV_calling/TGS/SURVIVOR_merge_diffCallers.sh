#!/bin/sh
# =====================================================================
# Merge structural variants (SVs) from multiple callers using SURVIVOR
# =====================================================================

VCF_File_List=$1
OUT_VCF=$2
~/software/SURVIVOR-master/Debug/SURVIVOR merge ${VCF_File_List} 1000 2 1 1 0 50 ${OUT_VCF}