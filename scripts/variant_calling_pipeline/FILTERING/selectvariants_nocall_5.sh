#!/bin/bash

#activate a base conda environment
eval "$(conda shell.bash hook)"

#now activate the conda environment you want to use
conda activate gatk4
gunzip plate_2_filtered2_PASS.vcf.gz ## EDIT NAMES

### FILTER OUT "NO CALL" VARIANTS
gatk SelectVariants -V plate_2_filtered2_PASS.vcf --set-filtered-gt-to-nocall -O plate_2_filtered2_PASS_GT.vcf ## EDIT NAMES


