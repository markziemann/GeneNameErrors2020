#!/bin/bash

RES=$1
INPUT=pmc2015.txt

N_XLS=$(cat $RES | awk 'NF==2 {print $1}' | sort -u | wc -l)
N_GN=$(cat $RES | awk 'NF==3 {print $1}' | sort -u | wc -l)
N_ERR=$(cat $RES | awk 'NF>3 {print $1}' | sort -u | wc -l)
PROP=$(echo $N_ERR $N_GN | awk '{print $1/$2 *100}' | numround -n .1 )

LAST=$(tail -1 $RES | awk '{print $1}')
LINE=$(grep -wn $LAST $INPUT | cut -d ':' -f1)
TOTAL_LINES=$(cat $INPUT | wc -l )
PROG=$( echo $LINE $TOTAL_LINES | awk '{print $1/$2 *100}' | numround -n .1 )

echo NumberOfPapersWithXLS: $N_XLS
echo NumberOfPapersWithGeneLists: $N_GN
echo NumberOfPapersWithGeneListErrors: $N_ERR
echo ErrorProp: $PROP %
echo Progress: $PROG %
