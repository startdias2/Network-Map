#!/bin/bash

# Function to generate DOT file from CSV conversation data
function generateDOTFile() {
    local input_file=$1
    local output_file=$2

    # Create a temporary DOT file
    local dot_file=$(mktemp)

    # Write DOT file header
    echo "strict graph IPAddresses {" >> "$dot_file"
    echo "    layout=neato;" >> "$dot_file"
    echo "    overlap=false;" >> "$dot_file"
    echo "    node [ style=filled, color=cornflowerblue ]" >> "$dot_file"

    # Read the input CSV file
    while IFS=',' read -r address_a address_b _; do
        # Remove double quotes from IP addresses
        address_a=$(echo "$address_a" | tr -d '"')
        address_b=$(echo "$address_b" | tr -d '"')

        # Write IP addresses to DOT file
        echo "    \"$address_a\" -- \"$address_b\";" >> "$dot_file"
    done < "$input_file"

    # Write DOT file footer
    echo "}" >> "$dot_file"

    # Copy DOT file to the specified output file
    cp "$dot_file" "$output_file"
}

# Default values
input_file="conversation.csv"
output_file="IPAddresses.dot"

# Generate DOT file with IP addresses
generateDOTFile "$input_file" "$output_file"

# Generate SVG file from DOT
dot -Tsvg "$output_file" -o IPAddresses.svg

# Open the SVG file in a web browser
start IPAddresses.svg
