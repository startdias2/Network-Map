#!/bin/bash

#1.4

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
    echo "    node [ style=filled ]" >> "$dot_file"

    # Declare an associative array to store connection counts
    declare -A connection_counts

    # Define the top 10 famous DNS servers
    top_dns_servers=(
        "8.8.8.8" "8.8.4.4"            # Google Public DNS
        "1.1.1.1" "1.0.0.1"            # Cloudflare DNS
        "208.67.222.222" "208.67.220.220"  # OpenDNS (Cisco Umbrella)
        "9.9.9.9"                      # Quad9
        "4.2.2.1" "4.2.2.2"            # Level3 (CenturyLink)
        "64.6.64.6" "64.6.65.6"        # Verisign DNS
        "199.85.126.10" "199.85.127.10"    # Norton ConnectSafe (Discontinued)
        "8.26.56.26" "8.20.247.20"     # Comodo Secure DNS
        "84.200.69.80" "84.200.70.40"  # DNS.WATCH
        "77.88.8.8" "77.88.8.1"        # Yandex.DNS
    )

    # Read the input CSV file
    while IFS=',' read -r address_a address_b _; do
        # Remove double quotes from IP addresses
        address_a=$(echo "$address_a" | tr -d '"')
        address_b=$(echo "$address_b" | tr -d '"')

        # Determine if address_a is a private IP
        if [[ "$address_a" =~ ^10\.|^192\.168\.|^172\.(1[6-9]|2[0-9]|3[01])\. ]]; then
            echo "    \"$address_a\" [ fillcolor=lightyellow ];" >> "$dot_file"
        elif [[ "$address_a" =~ ^0\.|^127\.|^169\.254\.|^192\.0\.0\.|^192\.0\.2\.|^224\.|^240\. ]]; then
            echo "    \"$address_a\" [ fillcolor=gold ];" >> "$dot_file"
        elif [[ " ${top_dns_servers[*]} " == *" $address_a "* ]]; then
            echo "    \"$address_a\" [ fillcolor=orange ];" >> "$dot_file"
        fi

        # Determine if address_b is a private IP
        if [[ "$address_b" =~ ^10\.|^192\.168\.|^172\.(1[6-9]|2[0-9]|3[01])\. ]]; then
            echo "    \"$address_b\" [ fillcolor=lightyellow ];" >> "$dot_file"
        elif [[ "$address_b" =~ ^0\.|^127\.|^169\.254\.|^192\.0\.0\.|^192\.0\.2\.|^224\.|^240\. ]]; then
            echo "    \"$address_b\" [ fillcolor=gold ];" >> "$dot_file"
        elif [[ " ${top_dns_servers[*]} " == *" $address_b "* ]]; then
            echo "    \"$address_b\" [ fillcolor=orange ];" >> "$dot_file"
        fi

        # Increment connection count for the pair (address_a, address_b)
        connection_counts["$address_a-$address_b"]=$((connection_counts["$address_a-$address_b"] + 1))

        # Write IP addresses to DOT file
        echo "    \"$address_a\" -- \"$address_b\" [label=< <b>${connection_counts["$address_a-$address_b"]}</b>> ];" >> "$dot_file"
    done < "$input_file"

    # Write DOT file footer
    echo "}" >> "$dot_file"

    # Copy DOT file to the specified output file
    cp "$dot_file" "$output_file"
}

# Function to open the SVG file based on user's preference
function open_svg() {
    local svg_file=$1
    local choice
    echo "How would you like to open the SVG file?"
    echo "1. Windows"
    echo "2. Linux"
    read -p "Enter your choice (1 or 2): " choice
    case $choice in
        1) start "$svg_file" ;;
        2) xdg-open "$svg_file" ;;
        *) echo "Invalid choice. Exiting." ;;
    esac
}

# Default values
input_file="conversation.csv"
output_file="IPAddresses.dot"

# Generate DOT file with IP addresses
generateDOTFile "$input_file" "$output_file"

# Generate SVG file from DOT
dot -Tsvg "$output_file" -o IPAddresses.svg

# Show completion message
echo "DOT file generated successfully."

# Open the SVG file based on user's preference
open_svg "IPAddresses.svg"
