#!/bin/sh
# ==============================================================
# Merge per-sample SURVIVOR SVs into a prefixulation-level VCF
# ==============================================================
VCF_File_List=$1
OUT_VCF=$2
~/software/SURVIVOR-master/Debug/SURVIVOR merge ${VCF_File_List} 1000 1 1 1 0 50 ${OUT_VCF}