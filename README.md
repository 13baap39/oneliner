# oneliner
all the vulnerability oneliner that are checked by me 

# CORS:
site="https://evil.com"; cat allsubDomlist.txt | while read url; do target=$(curl -sIL -H "Origin: $site" -X GET "$url"); if grep -q "Access-Control-Allow-Origin: $site" <<< "$target"; then echo "[vuln TO CORS] $url"; echo -e "$target\n" >> testCORS.txt; fi; done

