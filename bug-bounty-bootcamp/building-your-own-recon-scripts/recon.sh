#!/bin/bash

DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
TODAY=$(date)

nmap_scan()
{
  nmap $DOMAIN | tee $DIRECTORY/nmap.txt
  echo "The results of nmap scan are stored in $DIRECTORY/nmap.txt"

}

dirsearch_scan()
{
  python3 dirsearch.py $DOMAIN | tee $DIRECTORY/dirsearch.txt
  echo "the results of dirsearch are stored in $DIRECTORY/dirsearch.txt"
}

crt_scan()
{
  curl "https://crt.sh/?q=$DOMAIN&output=json" -o $DIRECTORY/crt.txt
  echo "The results of cert parsing is stored in $DIRECTORY/crt.txt"
}

echo "This scan was created on $TODAY."

echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY

case $2 in
  nmap-only)
    nmap_scan
    ;;
  dirsearch-only)
    dirsearch_scan
    ;;
  crt-only)
    crt_scan
    ;;
  *)
    nmap_scan
    dirsearch_scan
    crt_scan
    ;;
esac
