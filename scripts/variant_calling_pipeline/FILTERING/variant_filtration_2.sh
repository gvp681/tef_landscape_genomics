#!/bin/bash

## Activate a base conda environment
eval "$(conda shell.bash hook)"

## Now activate the conda environment you want to use
conda activate gatk4

## You will need to read up on and modify the parameters below. You will go back and fourth between this script and the next two to get it right for your population.

gatk VariantFiltration \
-V plate_2_select.vcf ## EDIT\
--filter-name "QD2" \
--filter-expression "QD < 2.0" ## EDIT\
--filter-name "FS10" \
--filter-expression "FS > 10.0" ## EDIT\
--filter-name "MQ42" \
--filter-expression "MQ < 42.0" ## EDIT\
-O plate_2_filtered2.vcf.gz ## EDIT

