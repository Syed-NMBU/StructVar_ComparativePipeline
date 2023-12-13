#!/bin/bash

# Script to merge multiple VCF files using BCFtools.
# This script is part of a bioinformatics pipeline and is used to combine VCF files from variant calling tools.
# Usage:
# - Place this script in the same directory as your normalized and indexed VCF files.
# - Ensure BCFtools and Tabix are loaded in your environment.
# - Execute the script in a bash shell or submit it as a job on a cluster with sbatch.

#SBATCH --job-name=vcf_merge              # Job name
#SBATCH --output=vcf_merge_%j.out         # Standard output log
#SBATCH --error=vcf_merge_%j.err          # Standard error log
#SBATCH --ntasks=1                        # Number of tasks (processes)
#SBATCH --mem=10G                         # Memory allocation
#SBATCH --time=24:00:00                   # Time limit hh:mm:ss

# Load the required modules for BCFtools and Tabix
# Adjust module names and versions according to your environment.
module load BCFtools/1.12-GCC-10.2.0
module load tabixpp/1.1.0-GCC-10.2.0

# Check if the BCFtools and Tabix modules were loaded successfully
if [[ $? -ne 0 ]]; then
    echo "$(date) - Error loading required modules. Check module names and paths." >> error_log.txt
    exit 1
fi

# Define the directory containing your VCF files
# Replace with your directory path where VCF files are located.
vcf_dir="/path/to/your/vcf_files"

# Create an array of all normalized and indexed VCF files
# Ensure your VCF files are named in a way that they can be captured by the wildcard expression.
vcf_array=(${vcf_dir}/normalized_Sample_*_delly_output_filtered.vcf.gz)

# Ensure that there are VCF files to merge
if [[ ${#vcf_array[@]} -eq 0 ]]; then
    echo "$(date) - No VCF files found in the directory." >> error_log.txt
    exit 1
fi

# Set the first VCF file as the base for merging
cp "${vcf_array[0]}" merged_samples_delly_output_filtered.vcf.gz

# Merge the VCF files incrementally
for ((i=1; i<${#vcf_array[@]}; i++)); do
    # Use a temporary file for the intermediate merge results
    mv merged_samples_delly_output_filtered.vcf.gz temp_merged.vcf.gz
    
    # Index the temporary merged VCF file
    tabix -p vcf temp_merged.vcf.gz
    if [[ $? -ne 0 ]]; then
        echo "$(date) - Error indexing VCF file before merge step $i." >> error_log.txt
        exit 1
    fi
    
    # Perform the merge operation with BCFtools
    bcftools merge -Oz temp_merged.vcf.gz "${vcf_array[$i]}" -o merged_samples_delly_output_filtered.vcf.gz 2>> error_log.txt
    if [[ $? -ne 0 ]]; then
        echo "$(date) - Error merging VCF files at step $i." >> error_log.txt
        exit 1
    fi
    
    # Clean up intermediate files
    rm temp_merged.vcf.gz temp_merged.vcf.gz.tbi
done

# Index the final merged VCF file for downstream processing
tabix -p vcf merged_samples_delly_output_filtered.vcf.gz 2>> error_log.txt
if [[ $? -ne 0 ]]; then
    echo "$(date) - Error indexing final merged VCF file." >> error_log.txt
    exit 1
fi

echo "$(date) - VCF merging completed successfully. Output file: merged_samples_delly_output_filtered.vcf.gz"
