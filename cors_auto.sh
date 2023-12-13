#!/bin/bash

read -p "Enter the location of the list of urls/domains(ex.../file/to/allurls.txt): " input_file
read -p "Enter the location of the output file (ex.../file/to/cors.txt): " output_file

if [ ! -f "$input_file" ]; then
    echo "Error: Input file not found."
    exit 1
fi

site="https://evil.com"
threads=10

cat "$input_file" | xargs -n 1 -P "$threads" -I {} bash -c \
  'target=$(curl -sIL -H "Origin: '"$site"'" -X GET "{}"); \
  if grep -q "Access-Control-Allow-Origin: '"$site"'" <<< "$target"; then \
    echo -e "[vuln TO CORS] {}\n$target\n" >> '"$output_file"'; \
  fi'

echo "CORS scan completed. Results saved to: $output_file"
