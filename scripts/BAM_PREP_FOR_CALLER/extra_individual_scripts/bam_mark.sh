#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --partition=shas
#SBATCH --qos=normal
#SBATCH --job-name=mark_bam
#SBATCH --output=mark_bam
for f in *nsorted_fixsorted.bam
do
r1=$f
r2=${f/nsorted_fixsorted.bam}sorted_fix_pos_mark.bam
samtools markdup $r1 $r2
done
