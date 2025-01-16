#!/bin/bash

echo "Creating directory $1_recon."

mkdir $1_recon
nmap $1 | tee $1_recon/nmap.txt

echo "The results of nmap scan are stored in $1_recon/nmap.txt"

python3 dirsearch.py $1 | tee $1_recon/dirsearch.txt

echo "the results of dirsearch are stored in $1_recon/dirsearch.txt"
