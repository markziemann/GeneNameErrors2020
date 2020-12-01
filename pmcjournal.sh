#!/bin/bash

# the purpose here is to parse the PMC summary text file and output a
# tabular file that links PMCIDs to journal names

PMC_SMRY=$1

OUT=$(echo $PMC_SMRY | sed 's/summary/journal/' | sed 's/.txt/.out.txt/')

cat $PMC_SMRY \
| grep -B1 PMCID \
| sed 's/(/./' \
| cut -d '.' -f1 \
| sed 's/PMCID: //' \
|  grep -v '\--' \
| paste - - \
| sed 's/ /_/g' \
| awk '{FS="\t"} {print $2"\t"$1}' > $OUT
