
![image](https://github.com/gvp681/tef_landscape_genomics/assets/63878806/7f1d2f45-b67f-498d-945d-fb2a8eb47576)

![image](https://github.com/gvp681/tef_landscape_genomics/assets/63878806/f490f6f0-dedb-4e55-98dd-4f3d14336d08)

<details>
<summary>BAM_PREP_FOR_CALLER STEPS</summary>

1.	Make sure reference fasta file is indexed before beginning
    Run $ bash index.sh 

2.	SANITY CHECK -- Check output errors and file sizes
  	Run $ ls -l (Go to each subdirectory and check for abnormal bam file sizes)
  	Run $ bash BAM_CHECK.sh *.bam 
  	Run $ less bam.txt (Check the bam.txt output from code above for error codes)

3.	Run Array of Pre-Processing Scripts through this One. Make sure your bam files are in the same folder as this script.
  	Run $ bash DSCI512_pipetest.sh
        See SNPPreProcessingHEIN.txt for information on individual scripts in folder /extra_individual_scripts
4.	Calculate Coverage Statistics (for observation)
  	Run $ bash CALCULATE_BAM_COVERAGE.sh 
  	Transfer gzipped bed file to local computer and run through Rstudio OR go to /COVERAGE_FIGURES and run in terminal (to create boxplots that will identify read count outliers and modal values)

</details>
