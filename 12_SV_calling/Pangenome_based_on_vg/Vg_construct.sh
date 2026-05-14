#!/bin/sh
REF=$1
VCF=$2
Thread=$3
prefix=$4

vg version
vg construct -r $REF -v $VCF -f -S -a -p -t $Thread > Bos-pg.${prefix}.vg
vg index -L -x Bos-pg.${prefix}.xg -t $Thread -p Bos-pg.${prefix}.vg
vg index -j Bos-pg.${prefix}.dist -t $Thread -p Bos-pg.${prefix}.vg
vg snarls --include-trivial Bos-pg.${prefix}.xg -t $Thread > Bos-pg.${prefix}.snarls
vg gbwt -x Bos-pg.${prefix}.xg -p -o Bos-pg.${prefix}.gbwt -P
vg minimizer -d Bos-pg.${prefix}.dist -o Bos-pg.${prefix}.min -g Bos-pg.${prefix}.gbwt -t $Thread -p Bos-pg.${prefix}.xg