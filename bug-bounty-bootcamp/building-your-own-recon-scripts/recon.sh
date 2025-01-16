#!/bin/bash

DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
TODAY=$(date)
echo "This scan was created on $TODAY."

echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY

if [ $2 == 'nmap-only' ]
then
  nmap $DOMAIN | tee $DIRECTORY/nmap.txt
  echo "The results of nmap scan are stored in $DIRECTORY/nmap.txt"
elif [ $2 == 'dirsearch-only' ]
then
  python3 dirsearch.py $DOMAIN | tee $DIRECTORY/dirsearch.txt
  echo "the results of dirsearch are stored in $DIRECTORY/dirsearch.txt"
else
  nmap $DOMAIN | tee $DIRECTORY/nmap.txt
  echo "The results of nmap scan are stored in $DIRECTORY/nmap.txt"
  python3 dirsearch.py $DOMAIN | tee $DIRECTORY/dirsearch.txt
  echo "the results of dirsearch are stored in $DIRECTORY/dirsearch.txt"
fi