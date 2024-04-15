#!/bin/bash

for f in *.bam
do
r1=$f
r2=${f/prop.bam}
r3=${r2}_RG.bam
java -jar picard.jar AddOrReplaceReadGroups \
-I $r1 \
-O $r3 \
--RGID $r2 \
--RGPL ILLUMINA \
--RGSM $r2 \
--RGLB DH \
--RGPU DH
date
done
