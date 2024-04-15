#!/usr/bin/env bash


####### MODIFY THIS SECTION #############

#The input samples live in directory:
inputdir="$(pwd -P)"

###################WE WILL NEED TO CHANGE THIS LINE BELOW #################
#Metadata file. This pulls the metadata path and file from the command line
ls *.bam | awk -F/ '{print $NF "," substr($NF, 1, 4)}' > bam_file_data.csv
metadata="$inputdir/bam_file_data.csv"

#This is the output_directory:
DATE=`date +%Y-%m-%d`
outputdir="$inputdir/"$DATE"_output/"


########## DONE MODIFYING ###############


########## BEGIN CODE ###############

echo -e ">>> INITIATING analyzer with command:\n\t$0 $@"

#Number of threads to use:
# Note - this imports the number of threads (ntasks) given in the command line
pthread=$2

# Make output directories
echo -e ">>> MAKING output directory"
echo -e "\tmkdir $outputdir"
mkdir -p $outputdir


#These are the sample names, R1:
#samples1=( $(cut -f 1 --output-delimiter=' ' $metadata) )
samples1=$(cut -d',' -f1 $metadata) #Kirsten Modification

#These are the sample names, R2:
#samples2=( $(cut -f 2 --output-delimiter=' ' $metadata) )

#These are the nicknames I want to give the files:
#My metadata file will differ from Erin's, for this would be column 3 in the original script
#names=( $(cut -f 2 --output-delimiter=' ' $metadata) )
names=$(cut -d',' -f2 $metadata) #Kirsten Modification

####### PIPELINE ##############

# Report back to the user which files will be processed and which names they'll be given:
echo -e ">>> INPUT: This script will process files from the metafile:\n\t$metadata"
echo -e ">>> PLAN: This script will process the sample files into the following names: "
#echo -e "\tSAMPLE1\tSAMPLE2\tNAMES" (Erin's original line)
echo -e "\tSAMPLE1\tNAMES"

for (( counter=0; counter < ${#samples1[@]}; counter++ ))
do
   # echo -e "\t${samples1[$counter]}\t${samples2[$counter]}\t${names[$counter]}"
     echo -e "\t${samples1[$counter]}\t${names[$counter]}"
done

return

# SAMTOOLS: to convert .sam output to uploadable .bam 
echo -e "\n>>> SAMTOOLS/BAMCOVERAGE: to convert files to uploadable _sort.bam and _sort.bam.bai files:"
samout=$outputdir
#mkdir -p $samout


for seqname in ${names[@]}
do
    # echo
    echo -e "\tSamtools: ${seqname}"

    # Samtools: compress .sam -> .bam
   # cmd5="samtools view --threads $pthread -bS ${outhisat2}${seqname}.sam > ${samout}${seqname}.bam"
   # echo -e "\t$ ${cmd5}"
   # time eval $cmd5


    # Samtools: sort by name .bam -> _sort.bam
    cmd6="samtools sort -n --threads $pthread ${seqname}.bam -o ${samout}${seqname}_nsorted.bam"
    echo -e "\t$ ${cmd6}"
    time eval $cmd6


    # Samtools: Identify duplicate reads in sorted bam files _nsorted.bam -> _nsorted_fix.bam
#    cmd66="samtools sort -n --threads $pthread ${samout}${seqname}_nsorted.bam -o ${samout}${seqname}_nsorted_fix.bam"
#    echo -e "\t$ ${cmd66}"
#    time eval $cmd66

    # Samtools: Sort alignments again—but by leftmost coordinate _nsorted_fix.bam -> _nsorted_fix.bam
#    cmd666="samtools sort -n --threads $pthread ${samout}${seqname}_nsorted_fix.bam -o ${samout}${seqname}_nsorted_fix.bam"
#    echo -e "\t$ ${cmd666}"
#    time eval $cmd666

    # Samtools: Mark duplicates ._nsorted_fix.bam -> _nsorted_fix_mark.bam
#    cmd7="samtools markdup ${seqname}_nsorted_fix.bam ${samout}${seqname}_nsorted_fix_mark.bam"
#    echo -e "\t$ ${cmd7}"
#    time eval $cmd7

    # Samtools: Removal of non prop paired _nsorted_fix_mark.bam -> _prop.bam
#    cmd8="samtools view -q 10 -f 0x002 -b ${samout}${seqname}_nsorted_fix_mark.bam > ${samout}${seqname}_prop.bam "
#    echo -e "\t$ ${cmd8}"
#    time eval $cmd8

    # Samtools: Index prop.bam -> prop.bam.bai
#    cmd9="samtools index ${samout}${seqname}_prop.bam"
#    echo -e "\t$ ${cmd9}"
#    time eval $cmd9

done
