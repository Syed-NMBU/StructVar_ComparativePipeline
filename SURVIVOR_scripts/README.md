# Structural Variant Merging with SURVIVOR

## Overview

This repository hosts a collection of scripts designed to merge VCF files produced by structural variant calling tools (Delly, Manta, and Smoove) using the SURVIVOR software. It includes scripts for the initial merging of VCFs for each individual tool and a final script to integrate these merged files into a comprehensive VCF file.

## Scripts and Usage

### Initial Merging Scripts

Each initial merging script takes multiple VCFs produced by a specific tool and merges them into a single VCF:

- `Delly_merge_vcf_with_survivor.sh`: Merges multiple VCFs from Delly.
- `Manta_merge_vcf_with_survivor.sh`: Merges multiple VCFs from Manta.
- `Smoove_merge_vcf_with_survivor.sh`: Merges multiple VCFs from Smoove.

To use these scripts, set the input directory containing your VCF files and the output path for the merged VCF file. Ensure SURVIVOR is installed and in your PATH. Run each script according to the instructions provided within.

### Final Integration Script

- `final_merge_survivor.sh`: This script integrates the merged VCFs from each tool into a final comprehensive VCF file.

After running the initial merge scripts, update the paths in `final_merge_survivor.sh` to point to the merged VCFs and specify the output directory for the final integrated VCF file. Run the script to perform the final merge.

## Prerequisites

Before running the scripts, ensure the following:
- A Unix-like environment with Bash.
- SURVIVOR installed and available in your system's PATH.
- Access to the VCF files produced by Delly, Manta, and Smoove.

## Configuration

Adjust the SURVIVOR parameters within each script as necessary for your specific merging requirements. Parameters include the maximum distance between breakpoints, the minimum number of supporting calls/Samples, and the minimum size of SVs to consider.

## Output

Each script will output a single merged VCF file. The `final_merge_survivor.sh` script will produce a comprehensive VCF file that combines the structural variant calls from all three tools.

## Support

For any issues or support with these scripts, please open an issue in this repository with a detailed description of your problem.

## Contributing

Contributions to improve or enhance these scripts are encouraged. Please fork the repository, commit your changes, and submit a pull request.

## License

All scripts in this directory are provided under the MIT License. See the LICENSE file in the repository's root for full details.
