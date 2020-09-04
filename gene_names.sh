#!/bin/bash

PMC=PMC4574564

screen_pmc(){

GENELIST_DIR='genelists/'
GENELISTS="${GENELIST_DIR}/*_genes"

RES=results.txt

PMC=$1

curl https://www.ncbi.nlm.nih.gov/pmc/articles/${PMC}/ > tmp.html

cat tmp.html | grep -i xls | tr '"' "\n" | egrep -i '(xls$|xlsx$)' | sort -u > tmp.txt

COUNT=$(cat tmp.txt | wc -l)

for XLS in $(cat tmp.txt ) ; do

  echo $PMC $XLS | tee -a $RES

  ERR_CNT=0

  SFX=$(echo $XLS | rev | cut -d '.' -f1 | rev)

  MYFILE=tmp.$SFX

  curl -o tmp.$SFX  "https://www.ncbi.nlm.nih.gov/$XLS" > $MYFILE

  sleep 2

  #ssconvert -S --export-type Gnumeric_stf:stf_assistant -O 'separator="'$'\t''"' \
  #  $MYFILE $MYFILE.txt 2> /dev/null

  Rscript read_xls.R $MYFILE 2> /dev/null

  #count the columns in each sheet
  for SHEET in $MYFILE.txt* ; do
    TMP=$SHEET.tmp
    NF=$(head $SHEET | awk '{print NF}' | numaverage -M)

    #intersect top 20 fields from each column of data with gene name lists
    for COL in $(seq $NF) ; do
      cut -f$COL $SHEET | head -20 > $TMP

      #Guess which species based on top 20 cells of the field
      SPEC=""
      SPEC=$(grep -cxFf $TMP $GENELISTS | awk -F: '$2>4' | sort -t\: -k2gr \
      | head -1 | cut -d ':' -f1 | tr '/' ' ' | awk '{print $NF}' \
      | cut -d '_' -f1)

      #If >4 of the top 20 cells are recognised as genes, then regex with awk
      if [ -n "$SPEC" ] ; then

        #Run the regen screen on the column
        ERR=""
        ERR=$(cut -f$COL $SHEET | sed '1,2d' \
        |  awk ' /[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]/ || /[0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ || (/[0-9]\-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)/) || /[0-9]\.[0-9][0-9]E\+[0-9][0-9]/ ' )

        if [ "$ERR" != "" ] ; then
          ERR_CNT=$((ERR_CNT+1))
          N_ERR=$(echo $ERR | wc -w)
          echo $PMC $XLS $SPEC $N_ERR $ERR | tee -a $RES
        else
         echo $PMC $XLS $SPEC | tee -a $RES
        fi
      fi
    done
    rm $SHEET
    rm *tmp
  done
done
rm tmp*
sleep 10
}
export -f screen_pmc

rm tmp*
>results.txt

#screen_pmc PMC4574564

>begin
screen_pmc $PMC
for PMC in $(head -1000 pmc2015.txt ) ; do
  screen_pmc $PMC
done
>finish
