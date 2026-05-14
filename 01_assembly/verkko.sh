#!/bin/sh
# ================================================
# Genome assembly using HiFi, ONT, and NGS reads
# Tools: verkko
# ================================================

# 1. Assembly using Verkko (HiFi + ONT + trio)
verkko -d ./ --hifi hifi.fq.gz --nano ont.filter50k.fq.gz --no-cleanup \
       --grid --ovs-run 8 60 60 --mer-run 4 32 60 --cns-run 8 32 40 \
       --ovb-run 8 60 60 --threads 32 --hap-kmers mat.hapmer.meryl pat.hapmer.meryl trio
