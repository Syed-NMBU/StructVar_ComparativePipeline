# Comparative Analysis of SV Detection in Arctic Charr

## Overview

This repository contains scripts and analysis workflows for comparing structural variant (SV) detection tools – Delly, Manta, and Smoove – using short-read sequencing data from Arctic Charr (*Salvelinus alpinus*). It includes a comprehensive set of tools and methodologies, ranging from depth of coverage analysis to detailed genomic comparisons and visualizations.

## Contents

- **Delly_scripts**: Scripts and workflows for processing and analyzing SVs using Delly.
- **Manta_scripts**: Scripts and workflows dedicated to the Manta tool for SV detection.
- **Smoove_scripts**: Collection of scripts for utilizing Smoove in SV analysis.
- **SURVIVOR_scripts**: Scripts for merging and integrating SV data using the SURVIVOR tool.
- **Mosdepth-analysis**: A script for batch processing of depth coverage analysis using Mosdepth.
- **R_scripts**: Custom R scripts for data visualization, including coverage plots and comparative analyses of the SVs detected by each tool.

## Installation

Each directory contains specific installation and execution instructions for the respective tools and scripts. Ensure that all dependencies are correctly installed and configured as per the individual tool requirements.

## Usage

Navigate to each tool-specific directory for detailed instructions on running the scripts. The typical workflow involves:

1. Running each tool (Delly, Manta, and Smoove) on your sequencing data.
2. Utilizing SURVIVOR to merge and compare the outputs from these tools.
3. Conducting statistical analyses and generating visualizations using the provided R scripts.

## Comparative Analysis

The primary objective is to evaluate and compare the performance and outputs of Delly, Manta, and Smoove in detecting structural variants in the Arctic Charr genome. The repository facilitates a thorough comparison based on various metrics and genomic insights.

## Data Visualization

The `R_scripts` directory contains tools for visualizing coverage data and the comparative results of SV detection, offering insights into the efficacy and characteristics of each tool.

## Contributing

Contributions to improve or expand upon the analysis workflows and scripts are welcome. Please fork the repository, make your changes, and submit a pull request for review.

## License

The materials and scripts in this repository are provided under the MIT License. See the `LICENSE` file for more details.

## Contact

For questions or support regarding the analysis and scripts, please open an issue in this repository.

