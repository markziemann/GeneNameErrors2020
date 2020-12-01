#!/bin/bash

# This script is designed to compare the performance of
# ssconvert and read_xls approaches to finding gene name errors

for XLS in *xlsx ; do

  cp $XLS tmp.xlsx

  echo ssconvert $XLS

  time ssconvert -S --export-type Gnumeric_stf:stf_assistant -O 'separator="'$'\t''"' \
    tmp.xlsx tmp.xlsx.txt  2> /dev/null

  rm tmp.xlsx.txt.*

  echo read_xls $XLS

  time Rscript4 read_xls.R tmp.xlsx  2> /dev/null

  rm tmp.xlsx.txt.*

  rm tmp.xlsx

done
