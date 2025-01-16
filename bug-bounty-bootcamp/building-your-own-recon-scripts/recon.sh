#!/bin/bash

DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
TODAY=$(date)

echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY
nmap $DOMAIN | tee $DIRECTORY/nmap.txt
echo "The results of nmap scan are stored in $DIRECTORY/nmap.txt"
python3 dirsearch.py $DOMAIN | tee $DIRECTORY/dirsearch.txt
echo "the results of dirsearch are stored in $DIRECTORY/dirsearch.txt"
