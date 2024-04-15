#!/bin/bash

gunzip plate_2_filtered2.vcf.gz ## EDIT NAMES

### FILTER FOR PASSING CALLS ###
grep -E '^#|PASS' plate_2_filtered2.vcf > plate_2_filtered2_PASS.vcf ## EDIT NAMES 
egrep -v "^#" plate_2_filtered2_PASS.vcf > plate_2_NH.vcf ## EDIT NAMES

head plate_2_NH.vcf ## EDIT NAMES

### EXTRACT PARAMETERS TO OBSERVE ###
cut -f 8 plate_2_NH.vcf > plate_2_cut.vcf # EDIT NAMES 
cat plate_2_cut.vcf | sed 's/^.*;DP=\([0-9]*\);.*$/\1/' > depth.txt # EDIT INPUT NAMES
cat plate_2_cut.vcf | sed 's/^.*;QD=\([0-9]*.[0-9]*\);.*$/\1/' > QD.txt # EDIT INPUT NAMES
cat plate_2_cut.vcf | sed 's/^.*;FS=\([0-9]*.[0-9]*\);.*$/\1/' > FS.txt # EDIT INPUT NAMES
cat plate_2_cut.vcf | sed 's/^.*;MQ=\([0-9]*.[0-9]*\);.*$/\1/' > MQ.txt # EDIT INPUT NAMES

