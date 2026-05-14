# SURVIVOR
bash SURVIVOR.sh

# vg construct
sh Vg_construct.sh T2T-Taurine1.0.fasta vg.vcf 16 T2T-Taurine1.0

# vg genotyping
fastq1="WGS/cleanFastq/${SampleName}_1.clean.fastq.gz"
fastq2="WGS/cleanFastq/${SampleName}_2.clean.fastq.gz"
sh Vg_genotyping.sh vgIndex $fastq1 $fastq2 16 $SampleName vgGenotyping
