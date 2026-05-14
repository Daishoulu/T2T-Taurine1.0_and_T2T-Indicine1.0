#!/bin/bash
# ================================================
# Genome completeness assessment using Compleasm
# ================================================
GENOME="genome.fasta"
OUTPUT_DIR="output_dir"
LINEAGE="mammalia"
THREADS=10
BUSCO_DB_DIR="busco_db_dir

# 1. Compleasm
compleasm run -a $GENOME \
              -o $OUTPUT_DIR \
              -l $LINEAGE \
              -t $THREADS \
              -L $BUSCO_DB_DIR
