#!/bin/bash

# SLURM job configuration
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --job-name=smoove_analysis
#SBATCH --output=/path/to/logs/smoove_analysis_%j.out
#SBATCH --error=/path/to/logs/smoove_analysis_%j.err

# Load required modules
module load singularity/rpm
module load SAMtools/1.11-GCC-10.2.0

# Set path for reference fasta and directory containing BAM files
fasta='/path/to/reference_genome.fasta'
bam_dir='/path/to/bam_directory/'

# Set output and log directories
output_dir='/path/to/results_directory/'
log_dir='/path/to/logs_directory/'

# Loop over a range of samples and run smoove for each
for i in {01..30}; do
    sample_name="Sample_$i"

    echo "Running smoove for $sample_name"

    # Create directories for the results and logs specific to each sample
    mkdir -p "${output_dir}${sample_name}"
    mkdir -p "${log_dir}${sample_name}"

    # Construct the file name for the BAM file
    bam_file="${bam_dir}${sample_name}_withRG.bam"

    # Execute smoove using singularity
    singularity exec /path/to/smoove_latest.sif smoove call --outdir "${output_dir}${sample_name}" -name $sample_name --fasta $fasta -p 1 --genotype $bam_file

    # Move the SLURM logs to the sample-specific log directory
    mv /path/to/logs/smoove_analysis_$SLURM_JOB_ID.out "${log_dir}${sample_name}/"
    mv /path/to/logs/smoove_analysis_$SLURM_JOB_ID.err "${log_dir}${sample_name}/"
done
