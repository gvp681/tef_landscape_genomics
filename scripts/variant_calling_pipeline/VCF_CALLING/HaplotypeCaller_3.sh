#!/bin/bash 

### This process is usually long and computation intensive. It is best to break up your files into folders with 20 bam files and their indices. 
### Run this for each folder, making modifications to the match the files of each. 
### YOU DO NOT WANT TO RUN EVERYTHING AT ONCE - TRUST ME!!!!!!!!!!!!!!!!!!!!!!!!!!!
INDIR=../AB ## EDIT
OUTDIR=../AB/variants_gatk_2AB ## EDIT
GEN=/mnt/data/kirsten/teff/reference/Eragrostis_tef_tef.fasta ## EDIT
 
mkdir -p $OUTDIR

## EDIT INPUT AND OUTPUT FILE NAMES
gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/DH56*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A2_2_S194.g.vcf #do not remove the .g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A2_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A2_2_S194.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A3_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A3_2_S195.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A4_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A4_2_S196.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A5_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A5_2_S197.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A6_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A6_2_S198.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A7_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A7_2_S199.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A8_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A8_2_S200.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A9_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A9_2_S201.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A10_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A10_2_S202.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A11_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A11_2_S203.g.vcf

date 

gatk HaplotypeCaller \
     -R $GEN \
     -I $INDIR/A12_2*RG.bam \
     -ERC GVCF \
     --output $OUTDIR/A12_2_S204.g.vcf

date
