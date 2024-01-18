#!/bin/bash

url=$1

if [ ! -d "$url" ]; then
    mkdir "$url"
fi

if [ ! -d "$url/recon" ]; then
    mkdir "$url/recon"
fi

echo "[+] Hunting subdomains with Assetfinder ..."

assetfinder $url >> "$url/recon/assets.txt"
cat "$url/recon/assets.txt" | grep "$url" >> "$url/recon/final.txt"
rm "$url/recon/assets.txt"

echo "[+] First task completed Task completed"

echo "[+] 2nd task started ..."
echo "[+] Scanning Alive domain ..."

cat $url/recon/final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/recon/alive.txt

echo "[+] 2nd task end .."
