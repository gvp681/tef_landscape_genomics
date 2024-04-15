#!/bin/bash

### Combine gvcf files in preparation for genotyping
### One argument file has all the individual vcf files with a -V flag before each one (-V M32_parent_D05_S321.g.vcf.gz -V 7710_parent_D03_S319.g.vcf.gz ....) 
### and the other has all chromosome names with an -L flag (-L 1 -L 2 ...)

## Unzip files
gunzip *.gz

## Create alias
shopt -s expand_aliases
alias gatk='/mnt/data/kirsten/teff/gatk/gatk'

## Activate a base conda environment
eval "$(conda shell.bash hook)"

## Now activate the conda environment you want to use
conda activate gatk4


gatk --java-options "-Xmx4g -Xms4g" GenotypeGVCFs \
 -R /mnt/data/kirsten/teff/reference/Eragrostis_tef_tef.fasta ## EDIT \
 -V gendb://my_database \
 -O plate_2.vcf.gz ## EDIT

