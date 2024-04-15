## ***VCF Filtering (Part 1 – in terminal)***
- Filter for biallelic sites and SNPs
    - ```bash select_variants_1.sh ```
- Filter for different sequence parameters
  - ```bash variant_filtration_2.sh ```
- Filter for passing calls and extract different sequence parameters as text files
  - ```bash FILTER_PASSING_EXTRACT_PARAMETERS_3.sh ```
- Filter parameter visualization
  - ```Rscript FILTER_PARAMETER_FIGURE_CHECK_4.r ```
- Filter out no-call genotypes
  - ```bash selectvariants_nocall_5.sh ```
  - ```bash gzip_6.sh ```

***TRANSFER FILTERED VCF FILE TO LOCAL COMPUTER USING FILEZILLA OR CYDUCK***

## ***VCF Filtering (Part 2 – in TASSEL (Bradbury et al., 2007) on local computer)***
- Open VCF file in TASSEL and check/filter for parameters such as:
    - Minor allele frequency 
    - Genotyping Call Rate
    - Heterozygosity
    - ETC
- Export new VCF file and use as desired
    - I would recommend gzipping the file to save on storage space

## ***Useful Resources***
- https://speciationgenomics.github.io/filtering_vcfs/
- https://knausb.github.io/vcfR_documentation/vcf_data.html
- https://knausb.github.io/vcfR_documentation/visualization_1.html
- https://knausb.github.io/vcfR_documentation/visualization_2.html
