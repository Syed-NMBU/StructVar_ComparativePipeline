# Manta Structural Variant Calling Scripts

## Overview

This directory contains a script to run the Manta structural variant caller on sequencing data. Manta is designed to rapidly and accurately detect structural variants in genomic data from next-generation sequencing (NGS) methods. The included script automates the variant calling process for multiple samples using Singularity containers.

## Script

- `run_manta.sh`: This script sets up and executes the Manta workflow for a range of samples, outputting the results to specified directories.

## Prerequisites

To run this script, you need:
- A Unix-like environment with a Bash shell.
- Singularity installed on your system.
- Access to the Manta Singularity container.
- BAM files prepared and stored in a specified directory.
- The reference genome in fasta format.

## Installation

No installation is necessary for the script itself, but ensure that all prerequisites are met and that Singularity and Manta are available on your system.

## Usage

To use the script, you must update the paths specified for the input BAM files, output directory, reference genome, and Manta container:

- `BAM_DIR`: Path to the directory containing your BAM files.
- `MANTA_DIR`: Path to the desired output directory for Manta results.
- `REFERENCE`: Path to your reference genome fasta file.
- `CONTAINER_PATH`: Path to your Manta Singularity container.

After setting the paths, submit the script to your job scheduler as follows:

```bash
sbatch run_manta.sh
