#!/bin/bash

for f in *mark.bam
do
r1=$f
r2=${f/mark.bam}prop.bam
samtools view -q 10 -f 0x002 -b $r1 > $r2
done
