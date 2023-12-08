#!/bin/bash

# Script for running Manta structural variant caller across multiple samples
# This script assumes the use of a Singularity container for Manta

# SLURM job configuration
#SBATCH --job-name=MantaSV
#SBATCH --output=MantaSV_%j.out
#SBATCH --error=MantaSV_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH --mem=60G
#SBATCH --time=48:00:00
#SBATCH --partition=orion

# Set paths and environment variables
# Users need to replace the paths with the locations specific to their system setup
BAM_DIR="/path/to/your/BAM_files"
MANTA_DIR="/path/to/your/Manta_output"
REFERENCE="/path/to/your/reference_genome.fasta"
CONTAINER_PATH="/path/to/your/manta_container.sif"

# Create the output directory if it doesn't exist
mkdir -p "${MANTA_DIR}"

# Loop over a predefined range of samples
for i in $(seq -w 1 30); do
    SAMPLE_NAME="Sample_$i"
    BAM_FILE="${BAM_DIR}/${SAMPLE_NAME}.bam"
    OUTPUT_DIR="${MANTA_DIR}/${SAMPLE_NAME}"

    # Check for the existence of the BAM file
    if [[ ! -f "${BAM_FILE}" ]]; then
        echo "BAM file not found for ${SAMPLE_NAME}, skipping..."
        continue  # Skip this sample if the BAM file is missing
    fi

    # Create the output directory for this sample's Manta results
    mkdir -p "${OUTPUT_DIR}"

    # Run the Manta configuration script using Singularity
    # The configuration script sets up the analysis run directory
    echo "Configuring Manta for ${SAMPLE_NAME}..."
    singularity exec ${CONTAINER_PATH} configManta.py \
        --bam="${BAM_FILE}" \
        --referenceFasta="${REFERENCE}" \
        --runDir="${OUTPUT_DIR}"

    # Change to the Manta run directory and execute the workflow
    echo "Running Manta workflow for ${SAMPLE_NAME}..."
    cd "${OUTPUT_DIR}"
    singularity exec ${CONTAINER_PATH} ./runWorkflow.py -m local -j ${SLURM_CPUS_PER_TASK}
done

echo "Manta analysis is complete for all processed samples."
