#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --partition=shas
#SBATCH --qos=normal
#SBATCH --job-name=fix_bam
#SBATCH --output=fix_bam
module_purge
for f in *sorted.bam
do
r1=$f
r2=${f/sorted.bam}sorted_fix.bam
samtools fixmate -m $r1 $r2
done
