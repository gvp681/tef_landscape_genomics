#!/bin/bash

for file in *RG.bam
do
r1=$file
samtools index $r1
done
