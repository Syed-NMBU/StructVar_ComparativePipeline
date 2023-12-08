#!/bin/bash

# General script for processing VCF files produced by Delly
# This script calculates the SVLEN for structural variants, annotates the VCF files with this information,
# and filters the variants based on size.

# Set the paths for input and output files
VCF_INPUT="/path/to/merged_samples_delly_output_filtered.vcf"
VCF_ANNOTATED="/path/to/merged_samples_delly_output_filtered_annotated.vcf"
VCF_FILTERED="/path/to/filtered_sv_greater_than_50bp.vcf"
ANNOTATIONS_FILE="/path/to/svlen_annotations.txt"

# Step 1: Calculate SVLEN and create an annotations file
# Extract SVLEN for variants where it is not provided using bcftools query and awk
echo "Calculating SVLEN and creating annotations file..."
bcftools query -f '%CHROM\t%POS\t%INFO/END\t%INFO/SVTYPE\t%INFO/SVLEN\n' $VCF_INPUT | \
awk -F'\t' 'BEGIN {OFS="\t"} {
    if ($4 == "INS" && $5 != ".") {
        svlen = $5
    } else {
        svlen = $3 - $2 + 1
    }
    print $1, $2, svlen
}' > $ANNOTATIONS_FILE

# Step 2: Annotate the VCF file with SVLEN information
# This ensures all structural variants in the VCF have complete length information
echo "Annotating VCF with SVLEN information..."
bcftools annotate -a $ANNOTATIONS_FILE -c CHROM,POS,INFO/SVLEN $VCF_INPUT -O v -o $VCF_ANNOTATED

# Step 3: Filter the annotated VCF
# Retain only those structural variants with a length of 50 bp or more
echo "Filtering VCF for SVs greater than 50 bp in length..."
bcftools view -i 'SVLEN>=50 || SVTYPE="BND"' $VCF_ANNOTATED -O v -o $VCF_FILTERED

echo "VCF processing complete. Filtered VCF saved to: $VCF_FILTERED"
