#!/bin/bash

## Activate a base conda environment
eval "$(conda shell.bash hook)"

## Now activate the conda environment you want to use
conda activate gatk4

#### Select Variants ####
## Produces a file retaining SNPs only. May not work with indel pipeline below. Modify if necessary.

gunzip plate_2.vcf.gz ## EDIT TO REFLECT NAME OF JOINT GENOTYPING FILE

gatk SelectVariants \
--reference /mnt/data/kirsten/teff/reference/Eragrostis_tef_tef.fasta ## EDIT TO MATCH REFERENCE NAME & LOCATION\
--variant plate_2.vcf ## EDIT TO MATCH NAME OF JOINT GENOTYPING FILE\
--select-type-to-include SNP \
--restrict-alleles-to BIALLELIC \
--output plate_2_select.vcf ## EDIT TO MATCH DESIRED OUTPUT NAME

gzip plate_2_select.vcf > plate_2_select.vcf.gz ## EDIT TO MATCH DESIRED INPUT/OUTPUT NAMES

