#!/bin/bash

# Script for merging VCF files obtained from Smoove using SURVIVOR
# This script assumes SURVIVOR is installed and in the user's PATH

# SLURM job configuration (if using an HPC environment)
#SBATCH --job-name=SurvivorMergeSmoove
#SBATCH --output=SurvivorMergeSmoove_%j.out  # Specifies the output file for the job log
#SBATCH --error=SurvivorMergeSmoove_%j.err   # Specifies the error file for the job log
#SBATCH --ntasks=1                            # Number of tasks (usually 1 for non-MPI jobs)
#SBATCH --cpus-per-task=1                     # Number of CPU cores per task
#SBATCH --mem=8G                              # Memory required (adjust as necessary)
#SBATCH --time=02:00:00                       # Time limit for the job

# Set the directory containing the Smoove VCF files to be merged
VCF_DIR="/path/to/your/smoove_vcf_files_directory"  # Replace with your directory path

# Define the output file for the merged VCF
MERGED_VCF="/path/to/your/output_directory/merged_smoove_vcf_file.vcf"  # Replace with your output path

# SURVIVOR parameters
MIN_SUPPORT="1"  # Minimum number of supporting VCF files for a variant to be included in the merge
DISTANCE_BETWEEN_BREAKPOINTS="100"  # Max distance between breakpoints
MIN_SV_SIZE="50"  # Minimum size of SVs to be taken into account

# Create a file list of Smoove VCF files to merge
echo "Creating list of Smoove VCF files to merge..."
find ${VCF_DIR} -name '*.vcf' > smoove_vcf_files_list.txt

# Run SURVIVOR to merge the Smoove VCF files
echo "Running SURVIVOR to merge Smoove VCF files..."
SURVIVOR merge smoove_vcf_files_list.txt ${DISTANCE_BETWEEN_BREAKPOINTS} ${MIN_SUPPORT} 1 1 0 ${MIN_SV_SIZE} ${MERGED_VCF}

echo "Smoove VCF merging complete. Merged file is located at: ${MERGED_VCF}"
