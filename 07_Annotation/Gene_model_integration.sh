#!/bin/sh
# 1. EVM Integration
## Prepare GFF3 files for integration
cat Glimmer.evm.gff Augustus.gff3 > prediction.gff3
mv GeMoMa.evm.gff3  protein_alignments.gff3
mv pasa_assemblies.gff3 transcript_alignments.gff3
sed -i "s/ngs_PASA/assembler-zi1807_PASA/g" transcript_alignments.gff3
sed -i "s/tgs_PASA/assembler-zi1807_PASA/g" transcript_alignments.gff3
## Define weight file for EVM
cat > weights_all.txt << END
ABINITIO_PREDICTION     Augustus        1
ABINITIO_PREDICTION     GlimmerHMM      0.1
PROTEIN                 GeMoMa  6
TRANSCRIPT            assembler-zi1807_PASA      10
END
## Run EVM to integrate predictions
EVidenceModeler-1.1.1/EvmUtils/partition_EVM_inputs.pl --genome genome.fasta --gene_predictions prediction.gff3 --transcript_alignments transcript_alignments.gff3 --protein_alignments protein_alignments.gff3 --segmentSize 2000000 --overlapSize 20000 --partition_listing partitions_list.out
EVidenceModeler-1.1.1/EvmUtils/write_EVM_commands.pl --genome genome.fasta --weights weights_all.txt --gene_predictions prediction.gff3 --transcript_alignments transcript_alignments.gff3 --protein_alignments protein_alignments.gff3 --output_file_name evm.out --partitions partitions_list.out > commands.list
bash commands.list
EVidenceModeler-1.1.1/EvmUtils/recombine_EVM_partial_outputs.pl  --partitions partitions_list.out   --output_file_name   evm.out
EVidenceModeler-1.1.1/EvmUtils/convert_EVM_outputs_to_GFF3.pl  --partitions partitions_list.out   --output  evm.out  --genome genome.soft.masked.fasta
cat */evm.out.gff3 > Integrate.EVM.gff3