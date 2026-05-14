# Genome Annotation Pipeline

This repository contains the commands and workflow used for genome annotation.

## 1. Repeat Annotation
- **GMATA**: SSR/microsatellite repeats
- **TRF**: Tandem repeats
- **MITE-Hunter**: Miniature inverted-repeat transposable elements
- **RepeatMasker**: Known transposable elements
- **RepeatModeler + TEclass**: De novo repeat prediction and classification
- **RepeatProteinMask**: Protein-based repeat annotation

## 2. Non-coding RNA Annotation
- **tRNAscan-SE**: tRNA genes
- **RNAmmer**: rRNA genes
- **Rfam/Infernal**: Structural RNAs (miRNA, snRNA, etc.)

## 3. Transcriptome-assisted Gene Prediction
- **NGS RNA-seq**: Clean reads, STAR alignment, StringTie assembly
- **ONT RNA-seq**: Full-length reads, minimap2 alignment, StringTie assembly

## 4. PASA Transcriptome Integration
- Integrate NGS and ONT transcripts
- Clean sequences and predict gene models using transcript evidence

## 5. Ab initio Gene Prediction
- **Augustus**: train and predict genes using RNA-seq hints
- **GlimmerHMM**: ab initio gene prediction

## 6. Homology-based Gene Prediction
- **GeMoMa**: predict genes using CDS from related species

## 7. Gene Model Integration
- **EVM**: integrate ab initio, transcriptome, and homology predictions

## 8. UTR Annotation
- PASA pipeline adds 5' and 3' UTRs

## Notes
- All commands include explanatory comments.
- Software versions and dependencies should be provided to ensure reproducibility.
- Input files: genome FASTA, transcriptome FASTQ/GTF.