#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --partition=shas
#SBATCH --qos=normal
#SBATCH --job-name=n_bam
#SBATCH --output=n_sort
module_purge
for f in *.bam
do
r1=$f
r2=${f/.bam}nsorted.bam
samtools sort -n $r1 -o $r2
done
