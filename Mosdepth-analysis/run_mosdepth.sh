#!/bin/bash

# SLURM directives
#SBATCH --array=1-30%5                   # Array job range and simultaneous job limit
#SBATCH --job-name=Mosdepth              # Job name
#SBATCH --partition=your_partition       # Cluster partition to submit the job
#SBATCH --nodes=1                        # Number of nodes to use
#SBATCH --ntasks-per-node=1              # Number of tasks per node
#SBATCH --cpus-per-task=8                # Number of CPU cores per task
#SBATCH --mem=100G                       # Memory allocation per job
#SBATCH --time=90:00:00                  # Job run time limit (HH:MM:SS)
#SBATCH --output=/path/to/your/output/directory/mos_%j.out  # Standard output file
#SBATCH --error=/path/to/your/output/directory/mos_%j.err   # Standard error file

# Set the path to the reference genome
# Replace with the path to your reference genome
REFERENCE="/path/to/your/reference/genome.fasta"

# Set the path to the Mosdepth binary
# Replace with the path to your Mosdepth executable
MOSDEPTH="/path/to/mosdepth/executable"

# Set the directory containing the BAM files to process
# Replace with your directory containing the BAM files
BAM_DIR="/path/to/your/BAM_files_directory"

# Create the output directory if it doesn't exist
mkdir -p /path/to/your/output/directory/mosdepth_output

# Loop through each BAM file in the BAM directory and run Mosdepth
# The script assumes BAM files have 'withRG' in their names indicating read groups are added
for bam in $BAM_DIR/*withRG.bam; do
    # Extract the base name of the file for use in output naming
    sample_name=$(basename $bam .bam)
    # Define the output prefix for Mosdepth outputs
    output_prefix="/path/to/your/output/directory/mosdepth_output/$sample_name"
    
    # Print the name of the file being processed to the console
    echo "Processing $bam..."
    
    # Run Mosdepth with the specified parameters
    $MOSDEPTH \
    --by 100 \                             # Window size for coverage calculation
    --fast-mode \                          # Enable fast mode (less accurate but quicker)
    --fasta $REFERENCE \                   # Reference genome for coverage calculations
    --no-per-base \                        # Disable per-base coverage reporting to save space
    $output_prefix \                       # Prefix for output files
    $bam                                   # Input BAM file
    
    # Print a confirmation once a file is processed
    echo "$bam processed."
done

# End of script
