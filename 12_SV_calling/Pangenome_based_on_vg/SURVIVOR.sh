#!/bin/sh
echo "NGS.DEL.vcf" > VCF.list
echo "TGS.vcf" >> VCF.list
echo "Bos-pg.T2T-Taurine.1.0.vcf" >> VCF.list
~/software/SURVIVOR-master/Debug/SURVIVOR merge VCF.list 1000 1 1 0 0 50 vg.vcf

