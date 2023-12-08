#!/bin/bash

# Final merging of tool-specific VCF files from DELLY, Manta, and Smoove using SURVIVOR
# This script assumes SURVIVOR is installed and accessible in the user's PATH

# SLURM job configuration (if using an HPC environment)
#SBATCH --job-name=FinalSurvivorMerge
#SBATCH --output=FinalSurvivorMerge_%j.out
#SBATCH --error=FinalSurvivorMerge_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=02:00:00

# Define the path to the merged VCF files from Delly, Manta, and Smoove
DELLY_MERGED_VCF="/path/to/delly/merged_delly.vcf"
MANTA_MERGED_VCF="/path/to/manta/merged_manta.vcf"
SMOOVE_MERGED_VCF="/path/to/smoove/merged_smoove.vcf"

# Define the output file for the final merged VCF
FINAL_MERGED_VCF="/path/to/final_output_directory/final_merged_vcf.vcf"

# SURVIVOR parameters
DISTANCE_BETWEEN_BREAKPOINTS="100"  # Max distance between breakpoints
MIN_SUPPORT="1"  # Minimum number of supporting tools to include a variant in the merge
MIN_SV_SIZE="50"  # Minimum size of SVs to be taken into account

# Create a file list of the merged VCF files from Delly, Manta, and Smoove
echo "Creating list of merged VCF files for the final SURVIVOR merge..."
echo -e "${DELLY_MERGED_VCF}\n${MANTA_MERGED_VCF}\n${SMOOVE_MERGED_VCF}" > merged_vcf_files_list.txt

# Run SURVIVOR to merge the VCF files
echo "Running the final SURVIVOR merge..."
SURVIVOR merge merged_vcf_files_list.txt ${DISTANCE_BETWEEN_BREAKPOINTS} ${MIN_SUPPORT} 1 1 0 ${MIN_SV_SIZE} ${FINAL_MERGED_VCF}

echo "Final merging complete. Comprehensive VCF file is located at: ${FINAL_MERGED_VCF}"
