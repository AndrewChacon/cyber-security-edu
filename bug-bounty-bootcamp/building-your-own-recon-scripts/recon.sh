#!/bin/bash

echo "Creating directory $1_recon."

mkdir $1_recon
nmap $1 > $1_recon/nmap

echo "The results of nmap scan are stored in $1_recon/nmap."

./dirsearch.py -u $1 -e php --simple-report=$1_recon/disearch

echo "the results of dirsearch are stored in $1_recon/dirsearch."
