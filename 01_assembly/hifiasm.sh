#!/bin/sh
# ================================================
# Genome assembly using HiFi, ONT, and NGS reads
# Tools: hifiasm
# ================================================

# 1. Assembly using HiFi reads only
hifiasm -o prefix -t 40 hifi.fq.gz

# 2. Assembly using HiFi reads + ONT long reads
hifiasm -o prefix -t 40 -ul ont.fq.gz hifi.fq.gz 

# 3. Assembly using HiFi reads + ONT reads + parental NGS data (trio-binning)
hifiasm -o prefix -t 40 -ul ont.fq.gz hifi.fq.gz -1 pat.yak -2 mat.yak

# 4. Assembly using ONT reads + parental NGS reads
hifiasm -o prefix -t 40 -ont ont.fq.gz --telo-m CCCTAA --rl-cut 10000 -1 pat.yak -2 mat.yak
