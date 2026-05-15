# PCA
```sh
sh PCA.sh T2T-Taurine1.0 16
sh PCA.sh T2T-Indicine1.0 16
sh PCA.sh ARS-UCD2.0 16
```

# Admixture
```sh
for k in {2..10};
do
sh Admixture.sh SNPs.T2T-Taurine1.0.bed $k T2T-Taurine1.0 16
sh Admixture.sh SNPs.T2T-Indicine1.0.bed $k T2T-Indicine1.0 16
sh Admixture.sh SNPs.ARS-UCD2.0.bed $k ARS-UCD2.0 16
done
```

# Tree
```sh
sh Tree.sh T2T-Taurine1.0
sh Tree.sh T2T-Indicine1.0
sh Tree.sh ARS-UCD2.0
```

# Pi
for prefix in T2T-Taurine1.0 T2T-Indicine1.0 ARS-UCD2.0;
do
for pop in Taurine Indicine;
do
bash Pi.sh SNPs.${prefix}.vcf.gz $pop T2T-Taurine1.0
done
done

# FST
```sh
for prefix in T2T-Taurine1.0 T2T-Indicine1.0 ARS-UCD2.0;
do
sh Taurine_vs_Indicine.FST_Windows.sh SNPs.${prefix}.vcf.gz Taurine Indicine $prefix
done

sh Taurine_vs_Indicine.FST.sh SVs.T2T-Taurine1.0.vcf.gz Taurine Indicine T2T-Taurine1.0
```

# Tajimas'D
```sh
for prefix in T2T-Taurine1.0 T2T-Indicine1.0 ARS-UCD2.0;
do
for pop in Taurine Indicine;
do
sh tajimaD.sh SNPs.${prefix}.vcf.gz ${pop}.list ${pop} 50000 $prefix
done
done
```

# LD
```sh
sh LD.sh
```

# smc++
## smc++ smc2vcf
```sh
for c in {1..29};do
sh Smc_smc2vcf.sh T2T-Taurine1.0 $c T2T-Taurine1.0_Taurine T2T-Taurine1.0_Indicine
sh Smc_smc2vcf.sh T2T-Indicine1.0 $c T2T-Indicine1.0_Taurine T2T-Indicine1.0_Indicine
sh Smc_smc2vcf.sh ARS-UCD2.0 $c ARS-UCD2.0_Taurine ARS-UCD2.0_Indicine
done
```

## smc++ estimate
```sh
sh Smc_estimate.sh T2T-Taurine1.0_Taurine T2T-Taurine1.0_Taurine
sh Smc_estimate.sh T2T-Taurine1.0_Indicine T2T-Taurine1.0_Indicine
sh Smc_estimate.sh T2T-Indicine1.0_Taurine T2T-Indicine1.0_Taurine
sh Smc_estimate.sh T2T-Indicine1.0_Indicine T2T-Indicine1.0_Indicine
sh Smc_estimate.sh ARS-UCD2.0_Taurine ARS-UCD2.0_Taurine
sh Smc_estimate.sh ARS-UCD2.0_Indicine ARS-UCD2.0_Indicine
```

