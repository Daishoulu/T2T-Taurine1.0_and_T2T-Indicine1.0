# Pbmm
```sh
sh Pbmm.sh T2T-Taurine1.0 Sample.HiFi.fasta.gz Sample
sh Pbmm.sh T2T-Indicine1.0 Sample.HiFi.fasta.gz Sample
sh Pbmm.sh ARS-UCD2.0 Sample.HiFi.fasta.gz Sample
```

# CuteSV
```sh
sh CuteSV.sh Sample.sort.bam T2T-Taurine1.0 Sample 16
sh CuteSV.sh Sample.sort.bam T2T-Indicine1.0 Sample 16
sh CuteSV.sh Sample.sort.bam ARS-UCD2.0 Sample 16
```

# Pbsv
```sh
sh Pbsv.sh Sample.sort.bam T2T-Taurine1.0 Sample
sh Pbsv.sh Sample.sort.bam T2T-Indicine1.0 Sample
sh Pbsv.sh Sample.sort.bam ARS-UCD2.0 Sample
```

# Sniffles
```sh
sh Sniffles.sh Sample.sort.bam Sample
```

# SURVIVOR
## merge diffCallers
```sh
echo "${Sample}.pbsv.vcf" >> ${Sample}.VCF.list
echo "${Sample}.sniffles.vcf" >> ${Sample}.VCF.list
echo "${Sample}.cuteSV.vcf" >> ${Sample}.VCF.list
sh SURVIVOR_merge_diffCallers.sh ${Sample}.VCF.list ${Sample}.vcf
```

## merge diffSamples
```sh
echo "${Sample1}.vcf" >> All_Sample_VCF.list
echo "${Sample2}.vcf" >> All_Sample_VCF.list
sh SURVIVOR_merge_diffSamples.sh All_Sample_VCF.list TGS.vcf
```

