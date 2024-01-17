#!/bin/bash

# Prompt for input and output locations
read -p "Enter the location of the URL file: " input_location
read -p "Enter the output location for vulnerable URLs: " output_location

# Create output file if it doesn't exist
touch "$output_location"

# Counter for tracking vulnerable URLs
counter=1

# Loop through each URL in the file
while IFS= read -r url || [ -n "$url" ]; do
    echo "Testing URL: $url"
    
    # Run shortscan tool on the current URL
    shortscan_output=$(shortscan "$url")

    # Check if the URL is vulnerable
    if [[ "$shortscan_output" == *"Vulnerable: Yes!"* ]]; then
        echo "Vulnerable URL found: $url"
        
        # Save vulnerable URL and test output to the output file
        echo "$counter. \"$url\"" >> "$output_location"
        echo "Vulnerable: Yes!" >> "$output_location"
        echo "-------------------------------------------------------" >> "$output_location"
        echo "$shortscan_output" >> "$output_location"
        
        # Increment the counter
        ((counter++))
    else
        echo "URL is not vulnerable."
    fi
done < "$input_location"

echo "Testing complete. Vulnerable URLs and test output saved to: $output_location"
