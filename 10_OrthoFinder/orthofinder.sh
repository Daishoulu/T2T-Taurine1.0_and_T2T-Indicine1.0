#!/bin/sh
# ================================================
# OrthoFinder: identify orthogroups
# ================================================

orthofinder -f ./pep.fasta -S diamond -t 20 -a 20 -o result
