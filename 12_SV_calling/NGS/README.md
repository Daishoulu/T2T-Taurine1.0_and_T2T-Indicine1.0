
# Breakdancer
sh Breakdancer.sh T2T-Taurine1.0.fasta.dict Sample.sort.dedup.bam outputDir Sample
sh Breakdancer.sh T2T-Indicine1.0.fasta.dict Sample.sort.dedup.bam outputDir Sample
sh Breakdancer.sh ARS-UCD2.0.fasta.dict Sample.sort.dedup.bam outputDir Sample

# Delly
sh Delly.sh T2T-Taurine1.0.fasta Sample.sort.dedup.bam Sample
sh Delly.sh T2T-Indicine1.0.fasta Sample.sort.dedup.bam Sample
sh Delly.sh ARS-UCD2.0.fasta Sample.sort.dedup.bam Sample

# Lumpy
sh Lumpy.sh Sample.sort.dedup.bam Sample

# Manta
sh Manta.sh Sample.sort.dedup.bam T2T-Taurine1.0.fasta outputDir 16
sh Manta.sh Sample.sort.dedup.bam T2T-Indicine1.0.fasta outputDir 16
sh Manta.sh Sample.sort.dedup.bam ARS-UCD2.0.fasta outputDir 16

# SURVIVOR
## merge diffCallers
sh SURVIVOR_merge_diffCallers.sh T2T-Taurine1.0 Samples.list outputDir
sh SURVIVOR_merge_diffCallers.sh T2T-Indicine1.0 Samples.list outputDir
sh SURVIVOR_merge_diffCallers.sh ARS-UCD2.0 Samples.list outputDir

## merge diffSamples
sh SURVIVOR_merge_diffSamples.sh T2T-Taurine1.0 Samples.list outputDir
sh SURVIVOR_merge_diffSamples.sh T2T-Indicine1.0 Samples.list outputDir
sh SURVIVOR_merge_diffSamples.sh ARS-UCD2.0 Samples.list outputDir