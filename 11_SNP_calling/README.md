Step 1: Align paired-end reads to the reference genome using BWA-MEM2

```sh
sh BWA-MEM2.sh
```

Step 2: Call variants per sample using GATK HaplotypeCaller in GVCF mode

```sh
sh GATK_Haplotyper.sh
```

Step 3: Combine per-sample GVCFs per chromosome

```sh
sh GATK_CombineGVCF.sh
```

Step 4: Genotype combined GVCFs

```sh
sh GATK_GenotypeGVCFs.sh
```

Step 5: Select only biallelic SNP

```sh
sh GATK_SelectSNP.sh
```

Step 6: Apply hard filters to SNP

```sh
sh GATK_VariantFiltration.sh
```

Step 7: Select passing SNPs only

```sh
sh GATK_SelectPASS.sh
```

