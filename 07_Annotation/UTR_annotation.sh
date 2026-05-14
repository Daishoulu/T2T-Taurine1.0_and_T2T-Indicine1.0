# Use PASA to add 5' and 3' UTR information
PASA/current/scripts/Load_Current_Gene_Annotations.dbi -c PASA.alignAssembly.config -g genome.soft.masked.fasta -P Integrate.EVM.gff3
PASA/current/scripts/Launch_PASA_pipeline.pl -c annotCompare.config -A -g genome.soft.masked.fasta -t transcript.rename.fasta.clean --CPU 15