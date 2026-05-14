#!/bin/sh
# ================================================
# OrthoFinder: identify orthogroups and orthologs among multiple species
# ================================================

orthofinder -f ./pep.fasta -S diamond -t 20 -a 20 -o result
