#!/bin/bash

# This script aggregates results of different years and
# adds the journal name

AGG=aggregated_res.txt

for TXT in results20*.txt ; do
  awk '{OFS="\t"} NF>3 {print $1,$2}' $TXT \
  | sort -u | sed "s/^/${TXT}\t/"
done > $AGG

sort -o $AGG  -k 2b,2 $AGG

cat ../../pmc/jan/pmc_journal20*jan.out.txt \
| sort -k 1b,1 > tmp

join -1 1 -2 2 tmp $AGG > tmp2

mv tmp2 $AGG

rm tmp

# summary
cut -d ' ' -f2 $AGG | sort | uniq -c | sort -k1nr | head

