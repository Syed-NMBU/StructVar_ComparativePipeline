# Mosdepth Analysis Automation Script

## Description
This repository contains a Bash script `run_mosdepth.sh` for automating the depth of coverage calculation on BAM files using the Mosdepth tool. It is designed for high-throughput genomic data processing within a SLURM-based high-performance computing (HPC) environment.

## Features
- Automation of Mosdepth for multiple BAM files
- SLURM job array integration for resource-efficient computation
- Configurable for different genomic references and project directories

## Prerequisites
- Unix-like environment (Linux, macOS)
- SLURM Workload Manager
- Mosdepth [Installation Guide](https://github.com/brentp/mosdepth#installation)

## Installation
Clone the repository to your local machine or HPC environment using the following command:
git clone https://github.com/yourusername/mosdepth-analysis.git

## Usage
To use the `run_mosdepth.sh` script:
1. Modify the `REFERENCE` and `BAM_DIR` variables in the script to point to your reference genome and directory containing BAM files, respectively.
2. Set the `MOSDEPTH` variable to the location of the Mosdepth binary on your system.
3. Submit the script to the SLURM queue with:
sbatch run_mosdepth.sh

## Customization
You can adjust the resource allocation parameters (`--mem`, `--cpus-per-task`, `--time`) in the script according to the specifications of your computing environment and the requirements of your dataset.

## Contributing
Contributions to this script are welcome! Please feel free to submit issues and pull requests through GitHub.

## License
This project is open source and available under the [MIT License](LICENSE).

## Contact
If you have any questions or feedback, please open an issue in the GitHub repository or contact the repository owner directly at `syed.muneeb.ur.rehman@nmbu.no`.

## Acknowledgments
Thank you to the developers of Mosdepth and to the contributors who offer suggestions and improvements for this script.
