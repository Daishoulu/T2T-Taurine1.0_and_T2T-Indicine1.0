# PCA
bash PCA.sh T2T-Taurine1.0 16
bash PCA.sh T2T-Indicine1.0 16
bash PCA.sh ARS-UCD2.0 16

# Admixture
for k in {2..10};
do
bash Admixture.sh SNPs.T2T-Taurine1.0.bed $k T2T-Taurine1.0 16
bash Admixture.sh SNPs.T2T-Indicine1.0.bed $k T2T-Indicine1.0 16
bash Admixture.sh SNPs.ARS-UCD2.0.bed $k ARS-UCD2.0 16
done

# Tree
bash Tree.sh T2T-Taurine1.0
bash Tree.sh T2T-Indicine1.0
bash Tree.sh ARS-UCD2.0

# Pi
for prefix in T2T-Taurine1.0 T2T-Indicine1.0 ARS-UCD2.0;
do
for pop in Taurine Indicine;
do
bash Pi.sh SNPs.${prefix}.vcf.gz $pop T2T-Taurine1.0
done
done

# FST
for prefix in T2T-Taurine1.0 T2T-Indicine1.0 ARS-UCD2.0;
do
bash Taurine_vs_Indicine.FST_Windows.sh SNPs.${prefix}.vcf.gz Taurine Indicine $prefix
done

bash Taurine_vs_Indicine.FST.sh SVs.T2T-Taurine1.0.vcf.gz Taurine Indicine T2T-Taurine1.0

# Tajimas'D
for prefix in T2T-Taurine1.0 T2T-Indicine1.0 ARS-UCD2.0;
do
for pop in Taurine Indicine;
do
bash tajimaD.sh SNPs.${prefix}.vcf.gz ${pop}.list ${pop} 50000 $prefix
done
done

# LD
bash LD.sh

# smc++
## smc++ smc2vcf
for c in {1..29};do
bash Smc_smc2vcf.sh T2T-Taurine1.0 $c T2T-Taurine1.0_Taurine T2T-Taurine1.0_Indicine
bash Smc_smc2vcf.sh T2T-Indicine1.0 $c T2T-Indicine1.0_Taurine T2T-Indicine1.0_Indicine
bash Smc_smc2vcf.sh ARS-UCD2.0 $c ARS-UCD2.0_Taurine ARS-UCD2.0_Indicine
done

## smc++ estimate
bash Smc_estimate.sh T2T-Taurine1.0_Taurine T2T-Taurine1.0_Taurine
bash Smc_estimate.sh T2T-Taurine1.0_Indicine T2T-Taurine1.0_Indicine
bash Smc_estimate.sh T2T-Indicine1.0_Taurine T2T-Indicine1.0_Taurine
bash Smc_estimate.sh T2T-Indicine1.0_Indicine T2T-Indicine1.0_Indicine
bash Smc_estimate.sh ARS-UCD2.0_Taurine ARS-UCD2.0_Taurine
bash Smc_estimate.sh ARS-UCD2.0_Indicine ARS-UCD2.0_Indicine