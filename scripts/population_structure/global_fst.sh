#!/bin/bash

##### Locations containing more than one sample were grouped and split into separate text files containing the prefix COORD_FST* 
##### See COORD_bins.csv in /Data for bins

# Define the main output file
#main_output="main_output.txt"

# Add column headers to the main output file
#echo "bin1 bin2" > "$main_output"

# Loop through each COORD file
for i in COORD_*.txt; do
  # Loop through each other COORD file
  for j in COORD_*.txt; do
    ri=${i/.txt}
    rj=${j/.txt}        
    # Skip if comparing the file with itself
    if [ "$i" == "$j" ]; then
      continue
    fi
    
    # Define the output file name
    output="${ri}_${rj}"

    # Run vcftools command
    vcftools --gzvcf plate_2_filtered2_PASS_GT_quantile_het50_min05_geno80_taxa.vcf.gz \
      --weir-fst-pop "$i" --weir-fst-pop "$j" --out "$output"

    # Check if output file exists and contains sites
    #if [ -s "${output}.weir.fst" ]; then
      # Append the bin1 and bin2 values to the main output file
     # bin1=$(awk 'NR==2{print $2}' "${output}.weir.fst")
     # bin2=$(awk 'END{print $2}' "${output}.weir.fst")
     # paste <(echo "$bin1") <(echo "$bin2") > temp_bins.txt

      # Append the data to the main output file with aligned bin1 and bin2
      #paste temp_bins.txt "${output}.weir.fst" >> "$main_output"
        #rm temp_bins.txt
    #fi
  done

## Only non-zero FST values were retained for further analysis
