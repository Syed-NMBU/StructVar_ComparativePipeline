# Smoove Structural Variant Calling Scripts

## Overview

This directory contains scripts to automate the calling of structural variants using `smoove`. The `smoove` tool simplifies the process of identifying variants from sequencing data and is commonly used in genomics workflows.

## Scripts

- `run_smoove.sh`: This is the main script that runs `smoove` for each sample. It handles the creation of output directories, executes `smoove`, and moves logs to their respective sample-specific directories.

## Prerequisites

To run the scripts in this directory, you will need:
- Access to a Unix-like environment with a Bash shell.
- Singularity installed on your system.
- SAMtools available and loaded.
- A set of BAM files to analyze.

## Usage

1. Update the paths in the `run_smoove.sh` script:
    - `fasta`: Path to the reference genome fasta file.
    - `bam_dir`: Directory containing BAM files to be processed.
    - `output_dir`: Directory where results should be saved.
    - `log_dir`: Directory where log files should be stored.

2. Load the required modules or ensure the required software is installed.

3. Submit the `run_smoove.sh` script to your job scheduler, if using an HPC environment, or run it directly from the command line.

## Configuration

The scripts may require configuration to match your computing environment:
- Modify SLURM job parameters as needed for your system's resources.
- Ensure the Singularity container path is correct for your setup.

## Output

The script will generate the following outputs for each sample:
- A directory containing the results of the `smoove` call.
- Log files for the SLURM job submission.

## Support

If you encounter any issues while using these scripts, please open an issue in this GitHub repository detailing the problem.

## Contribution

Contributions to improve these scripts are welcome. Please fork the repository, commit your improvements, and open a pull request.

## License

These scripts are provided under the MIT License. See the LICENSE file in the root of the repository for full details.
