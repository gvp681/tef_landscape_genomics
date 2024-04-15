#!/bin/bash

# run this script like bash BAM_CHECK.sh *.bam

for file in $@
do
    samtools quickcheck $file # this sets $? to 0 if successful
    if  [ "$?" -eq 0 ]
    then
        echo "$file is OK"
    else
        echo "$file is not OK"
    fi
done

