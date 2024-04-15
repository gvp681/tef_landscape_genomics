#!/bin/bash

### Combine gvcf files in preparation for genotyping
### One argument file has all the individual vcf files with a -V flag before each one (-V M32_parent_D05_S321.g.vcf.gz -V 7710_parent_D03_S319.g.vcf.gz ....) 
### and the other has all chromosome names with an -L flag (-L 1 -L 2 ...)

###### MAKE AN INTERVALS FILE BEFORE RUNNING - CHECK MY INTERVALS.LIST FILE TO REFERENCE ######

## Unzip files
gunzip *.gz

## Create alias
shopt -s expand_aliases
alias gatk='/mnt/data/kirsten/Chad_GENCOVE/VCF_CALLING/gatk/gatk'

## Activate a base conda environment
eval "$(conda shell.bash hook)"

## Now activate the conda environment you want to use

### you may need to set up your own environment - try mine first ###
### its a conda environment where gatk is installed - there are plenty of online resources to aid in this ###

conda activate gatk4

## EDIT - each file below needs to be changed to match your vcf file names. 
gatk --java-options "-Xmx4g -Xms4g" GenomicsDBImport \
-V A1_*.vcf \
-V A2*.vcf \
-V A3*.vcf \
-V A4*.vcf \
-V A5*.vcf \
-V A6*.vcf \
-V A7*.vcf \
-V A8*.vcf \
-V A9*.vcf \
-V A10*.vcf \
-V A11*.vcf \
-V A12*.vcf \
-V B1_*.vcf \
-V B2*.vcf \
-V B3*.vcf \
-V B4*.vcf \
-V B5*.vcf \
-V B6*.vcf \
-V B7*.vcf \
-V B8*.vcf \
-V B10*.vcf \
-V B11*.vcf \
-V B12*.vcf \
-V C1_*.vcf \
-V C2*.vcf \
-V C3*.vcf \
-V C4*.vcf \
-V C5*.vcf \
-V C6*.vcf \
-V C7*.vcf \
-V C8*.vcf \
-V C9*.vcf \
-V C10*.vcf \
-V C11*.vcf \
-V C12*.vcf \
-V D1_*.vcf \
-V D2*.vcf \
-V D3*.vcf \
-V D4*.vcf \
-V D5*.vcf \
-V D6*.vcf \
-V D7*.vcf \
-V D8*.vcf \
-V D9*.vcf \
-V D10*.vcf \
-V D11*.vcf \
-V D12*.vcf \
-V E1_*.vcf \
-V E2*.vcf \
-V E3*.vcf \
-V E4*.vcf \
-V E5*.vcf \
-V E6*.vcf \
-V E7*.vcf \
-V E8*.vcf \
-V E9*.vcf \
-V E10*.vcf \
-V E11*.vcf \
-V E12*.vcf \
-V F1_*.vcf \
-V F2*.vcf \
-V F3*.vcf \
-V F4*.vcf \
-V F5*.vcf \
-V F6*.vcf \
-V F7*.vcf \
-V F8*.vcf \
-V F9*.vcf \
-V F10*.vcf \
-V F11*.vcf \
-V F12*.vcf \
-V G1_*.vcf \
-V G2*.vcf \
-V G3*.vcf \
-V G4*.vcf \
-V G5*.vcf \
-V G6*.vcf \
-V G7*.vcf \
-V G8*.vcf \
-V G9*.vcf \
-V G10*.vcf \
-V G11*.vcf \
-V G12*.vcf \
-V H1_*.vcf \
-V H2*.vcf \
-V H3*.vcf \
-V H4*.vcf \
-V H5*.vcf \
-V H6*.vcf \
-V H7*.vcf \
-V H8*.vcf \
-V H9*.vcf \
-V H10*.vcf \
-V H11*.vcf \
-V H12*.vcf \
--genomicsdb-workspace-path my_database --batch-size 25 --consolidate --arguments_file intervals.list -R ../../reference/Eragrostis_tef_tef.fasta  > combine_gvcf_plate2.out

## Edit the final line to match your reference file, desired output file name, and intervals list names/locations
