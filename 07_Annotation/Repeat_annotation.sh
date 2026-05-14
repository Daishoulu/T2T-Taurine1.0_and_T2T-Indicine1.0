#!/bin/sh
# 1. GMATA Analysis
gmata.pl -c GMATA-master/default_cfg.txt -i genome.fasta

# 2. TRF Analysis
trf genome.fasta 2 7 7 80 10 50 500 -f -d -h -l 6

# 3. MITE Analysis
MITE_Hunter_manager.pl -i genome.fasta -n 20 -P 0.1 -S 12345678 -c 25 -g zi1807_MITE

# 4. RepeatMasker Analysis
RepeatMasker -nolow -no_is -gff -norna -parallel 16 -engine abblast -lib animal.lib -dir . genome.fasta

# 5. RepeatModeler Analysis
RepeatModeler-open-1.0.11/BuildDatabase -name zi1807 -engine wublast genome.fasta.masked
RepeatModeler-open-1.0.11/RepeatModeler -pa 30 -database zi1807 -engine wublast

# 6. TEclass Analysis
TEclass-2.1.3/bin/TEclassTest -c TEclass-2.1.3/classifiers zi1807.repeatmodeler.unknown.fasta

# 7. RepeatProteinMask Analysis
RepeatProteinMask -engine wublast -noLowSimple -pvalue 1e-04 genome.fasta