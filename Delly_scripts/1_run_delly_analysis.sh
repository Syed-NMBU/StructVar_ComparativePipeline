#!/bin/bash

# SLURM job options
#SBATCH --job-name=DellySV
#SBATCH --partition=orion
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=90:00:00
#SBATCH --output=delly_%j.out
#SBATCH --error=delly_%j.err
#SBATCH --array=1-9

# Enable Bash strict mode to handle errors more reliably
set -euo pipefail

# Load necessary modules, such as BCFtools
module load BCFtools/1.12-GCC-10.2.0

# Set paths for input BAM files, output directory, reference genome, and container path
BAM_DIR="/path/to/bam_directory"                     # Replace with your BAM directory path
DELLY_DIR="/path/to/delly_output_directory"          # Replace with your Delly output directory path
REFERENCE="/path/to/reference_genome.fasta"          # Replace with your reference genome path
CONTAINER_PATH="/path/to/delly_container.sif"        # Replace with your Delly container image path
LOG_FILE="/path/to/delly_run.log"                    # Replace with your desired log file path

# Log function to append messages to a log file with timestamps
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "${LOG_FILE}"
}

# Function to run Delly for the given array index (Sample number)
run_delly_for_index() {
    local sample_number=$(printf "%02d" "$1")
    local bam_file="${BAM_DIR}/Sample_${sample_number}.bam"
    local output_file="${DELLY_DIR}/Sample_${sample_number}_delly_output.bcf"

    # Ensure the output directory exists
    mkdir -p "${DELLY_DIR}"

    # Skip processing if the BCF output file already exists
    if [[ -f ${output_file} ]]; then
        log "BCF output already exists for Sample_${sample_number}. Skipping."
        return
    fi

    # Check if the VCF output file already exists
    local output_vcf="${DELLY_DIR}/Sample_${sample_number}_delly_output.vcf"
    if [[ -f ${output_vcf} ]]; then
        log "VCF output already exists for Sample_${sample_number}. Skipping."
        return
    fi

    # Check if the input BAM file exists
    if [[ ! -f ${bam_file} ]]; then
        log "Error: BAM file not found: ${bam_file}"
        return
    fi

    # Log the start of Delly processing
    log "Running Delly for Sample_${sample_number}"
    # Run Delly using Singularity container
    singularity exec ${CONTAINER_PATH} delly call -g ${REFERENCE} -o ${output_file} ${bam_file}

    # Convert the BCF to a readable VCF format
    log "Converting BCF to VCF for Sample_${sample_number}"
    bcftools view ${output_file} > ${output_vcf}

    # Print and log the number of SVs detected by Delly
    local sv_count=$(grep -v ^\#\# ${output_vcf} | wc -l)
    log "Number of SVs detected by Delly for Sample_${sample_number}: ${sv_count}"
}

# Initialize the log file with the current SLURM task ID
echo "Delly Missing Samples Run Log for Sample_${SLURM_ARRAY_TASK_ID}" > "${LOG_FILE}"

# Execute the Delly processing function for the current SLURM array task
run_delly_for_index "${SLURM_ARRAY_TASK_ID}"
