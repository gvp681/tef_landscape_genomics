#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --partition=shas
#SBATCH --qos=normal
#SBATCH --job-name=prop_bam
#SBATCH --output=prop_index
module_purge
for f in *_prop.bam
do
samtools index $f
done
