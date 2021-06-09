#!/bin/bash
set -x
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
# run the monthly report

# here is the cron job for 3rd day of the month
#0 0 3 * * /bin/bash /home/mdz/projects/GeneNameErrors2020/monthly.sh >> /home/mdz/projects/GeneNameErrors2020/cron.log 2>&1

# because it is cron scheduled it needs to cd to the directory where the files are located
#cd "$(dirname "$0")"

cd /home/mdz/projects/GeneNameErrors2020

date >> monthly_start.txt

R -e rmarkdown::render"('monthly.Rmd',output_file='monthly.html')"

MYDATE=$(date "+%Y-%m")

cp monthly.html ~/public/gene_name_errors/Report_${MYDATE}.html
