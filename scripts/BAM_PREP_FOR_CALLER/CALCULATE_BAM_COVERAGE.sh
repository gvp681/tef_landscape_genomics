#!/bin/bash 

hostname
date

## define and/or create input, output directories

INDIR=../test_bam_coverage ## EDIT
OUTDIR=../test_bam_coverage/coverage_stats ## EDIT
mkdir -p $OUTDIR

## genome index file from samtools faidx
FAI=../../reference/Eragrostis_tef_tef.fasta.fai ## EDIT

## make a "genome" file, required by bedtools makewindows command, set variable for location
GFILE=$OUTDIR/Eragrostis_tef_tef.fasta.genome ## EDIT
cut -f 1-2 $FAI > $GFILE

## make 1kb window bed file, set variable for location
WIN1KB=$OUTDIR/Erag_1kb.bed ## EDIT
bedtools makewindows -g $GFILE -w 1000 >$WIN1KB


## make a list of bam files
find $INDIR -name "B*bam" >$OUTDIR/bam.list

## summarize coverage as the number of fragments mapping to 1kb windows across the genome
## pipe:
	# 1) merge bam files
	# 2) filter by quality and proper pairing
	# 3) convert alignments to bed format
	# 4) map alignments to 1kb windows, counting (but also getting the mean and median of the mapping quality score from column 5)

bamtools merge -list $OUTDIR/bam.list | \
bamtools filter -in - -mapQuality ">30" -isDuplicate false -isProperPair true | \
bedtools bamtobed -i stdin | \
bedtools map \
-a $WIN1KB \
-b stdin \
-c 5 -o mean,median,count \
-g $GFILE | \
bgzip >$OUTDIR/coverage_1kb.bed.gz

## bgzip compress and tabix index the resulting file
tabix -p bed $OUTDIR/coverage_1kb.bed.gz





