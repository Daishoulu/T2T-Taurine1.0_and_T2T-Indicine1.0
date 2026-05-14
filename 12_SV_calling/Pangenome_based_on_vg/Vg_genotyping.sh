#!/bin/sh
Index=$1
Fastq1=$2
Fastq2=$3
Threads=$4
SampleName=$5
OutDir=$6

mkdir -p $OutDir/${SampleName}
cp $Index/Bos-pg.T2T-Taurine1.0.dist $OutDir/${SampleName}
vg version
vg giraffe -x $Index/Bos-pg.T2T-Taurine1.0.xg -H $Index/Bos-pg.T2T-Taurine1.0.gbwt -m $Index/Bos-pg.T2T-Taurine1.0.min -d $OutDir/${SampleName}/Bos-pg.T2T-Taurine1.0.dist -f $Fastq1 -f $Fastq2 -t $Threads -b fast -N $SampleName -p > $OutDir/${SampleName}.gam
vg pack -x $Index/Bos-pg.T2T-Taurine1.0.xg -g $OutDir/${SampleName}.gam -t $Threads -o $OutDir/${SampleName}.pack
vg call $Index/Bos-pg.T2T-Taurine1.0.xg -r $Index/Bos-pg.T2T-Taurine1.0.snarls -k $OutDir/${SampleName}.pack -s $SampleName -v $Index/T2T-Taurine1.0.vg.norm.filter.vcf.gz -t $Threads --bias-mode --het-bias 2,4 > $OutDir/${SampleName}.vcf

rm $OutDir/${SampleName}.gam $OutDir/${SampleName}.pack