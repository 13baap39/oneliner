# oneliner
all the vulnerability oneliner that are checked by me 

# CORS:
site="https://evil.com"; cat demo.txt | while read url; do target=$(curl -sIL -H "Origin: $site" -X GET "$url"); if grep -q "Access-Control-Allow-Origin: $site" <<< "$target"; then echo -e "[vuln TO CORS] $url\n$target\n" >> testdemo.txt; fi; done

