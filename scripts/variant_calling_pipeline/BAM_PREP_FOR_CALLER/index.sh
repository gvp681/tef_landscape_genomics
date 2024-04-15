#!/bin/bash

for f in *prop.bam
do
samtools index $f
done
