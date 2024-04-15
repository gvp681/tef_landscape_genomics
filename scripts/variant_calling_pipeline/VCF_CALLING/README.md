# /VCF_CALLING/ STEPS
***SNP calling was performed using the GATK HaplotypeCaller with default settings, and the resulting Genomic Variant Call Format files were combined into a single database using GenomicDBImport for joint genotyping with GenotypeGVCF.***
- Add read group headers
    - ```bash addRG_1.sh ```
- Re-index new bam files
    - ```bash index_2.sh ```
- Variant Caller – Read Warning in Script
    - ```bash HaplotypeCaller_3.sh ```
- Combine vcf files into a single database
    - ```bash genomicsDBI_gvcf_4.sh ```
- Joint Genotyping
    - ```bash genotypegvcf_5.sh ```
    - ```bash gzip_6.sh ```
- Go to /FILTERING/
