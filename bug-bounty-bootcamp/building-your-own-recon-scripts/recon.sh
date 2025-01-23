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
  curl -v "https://crt.sh/?q=$DOMAIN&output=json" > $DIRECTORY/crt.txt
  echo "The results of cert parsing is stored in $DIRECTORY/crt.txt"
}

echo "This scan was created on $TODAY."

echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY

getopts "m:" OPTION
MODE=$OPTARG

for i in "${@:$OPTIND:$#}"
do

  DOMAIN=$i
  DIRECTORY=${DOMAIN}_recon
  echo "Creating directory $DIRECTORY."
  mkdir $DIRECTORY

  case $MODE in
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

  echo "Generating recon report from output files..."
  echo "This scan was created on $TODAY" > $DIRECTORY/report.txt
    if [ -f $DIRECTORY/nmap ]; then
    echo "Results for Nmap:" >> $DIRECTORY/report.txt
    grep -E "^\s*\S+\s+\S+\s+\S+\s*$" $DIRECTORY/nmap.txt >> $DIRECTORY/report.txt
  fi
    if [ -f $DIRECTORY/dirsearch ]; then
    echo "Results for Dirsearch:" >> $DIRECTORY/report.txt
    cat $DIRECTORY/dirsearch.txt >> $DIRECTORY/report.txt
  fi
    if [ -f $DIRECTORY/crt ]; then
    echo "Results for crt.sh:" >> $DIRECTORY/report.txt
    jq -r ".[] | .name_value" $DIRECTORY/crt.txt >> $DIRECTORY/report.txt
  fi
  done
