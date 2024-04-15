#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --partition=shas
#SBATCH --qos=normal
#SBATCH --job-name=prop_bam
#SBATCH --output=prop_bam
for f in *sorted_fix_pos_mark.bam
do
r1=$f
r2=${f/sorted_fix_pos_mark.bam}prop.bam
samtools view -q 10 -f 0x002 -b $r1 > $r2
done
