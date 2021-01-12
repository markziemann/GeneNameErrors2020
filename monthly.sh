#!/bin/bash

# run the monthly report

# here is the cron job for 3rd day of the month
#0 0 3 * * bash /mnt/mziemann/projects/GeneNameErrors2020/monthly.sh

# because it is cron scheduled it needs to cd to the directory where the files are located
cd "$(dirname "$0")"

R -e rmarkdown::render"('monthly.Rmd',output_file='monthly.html')"

MYDATE=$(date "+%Y-%m")

cp monthly.html ~/public/gene_name_errors/Report_${MYDATE}.html
