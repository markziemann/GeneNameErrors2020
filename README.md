# GeneNameErrors2020

The purpose of this repository is to understand whether gene name errors remain a problem in the scientific literature.

The goal of this work is to screen PubMed Central for MS Excel spreadsheets and search for gene lists and evidence that gene names have been auto-converted to dates and other data types in error.

# Contents

## Software

* gene_names.sh is the script used to screen all the PMC records for Excel spreadsheets and gene name errors.

* comparison.sh is a script used to test the performance of programs to convert spreadsheets to tabular data files

* analyze.sh this is a short script used to process and summarise the results from gene_names.sh script

* read_xls.R is a helper Rscript that executes the readxl function which is very efficient at extracting tabular data from Excel sheets.

* pmcjournal.sh parses the PMC summary text file and outputs a tabular file that links PMCIDs to journal names

* monthly.sh is a script which runs monthly reports on the number of publications with gene name errors by searching for auto-converted gene names in related supplementary files in PubMed Central. 

* results_summary.Rmd is a markdown file which consists of analysis of output data from bash script "gene_names.sh" which is used in screening a list of PMC articles. This mark down file use the output data to generat figures related to the paper.

* monthly.Rmd is a markdown file used in analysing trends and insights of the distribution of gene name errored publications by identifyig gene name errors present in supplementary files in PubMed Central. 


## Input data

There are several files like pmc2015.txt which is a list of PMC papers. I
These were generated by searching PMC (https://www.ncbi.nlm.nih.gov/pmc) with the following strategy:

(genom*[Abstract]) AND ("2015"[Publication Date] : "2015"[Publication Date]) 

The 2015 papers were obtained on the 3rd Sept and the 2016-2019 papers were obtained on the 10th September.

In the folder "pmc" there are several files such as pmc_journal2014genom.out.txt which contain every pmc publication of 2014 which is output by PubMed Central for the keyword "genom". These files contain the pubMed Central ID and respective journal.

There are several files such as pmc_summary2014genom.txt which consist of summary of the publications obtained via pmc_journal2014genom.out.txt and these files consists of name of the publication,respective authors,year of publication,publication date and doi number.

* jifs.tsv is a tsv file which contain respective impact factors for the journals 

* plosone_20142015.tsv is a tsv file which consists of gene name errored publications of PLOS ONE from 2014-2015. This is the data fron the previous analysis done in 2016.(https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1044-7)

In the folder "results" there are several text files(aggregated_res.txt,false.positive.txt,true.positive.txt)

* aggregated_res.txt is a text file which consists of list genes which are of erroneous conversions, such as date formats, scientific numbers and five-digit numbers. 

* false.positive.txt is a text file which compose of tatal number of false positive results which was recorded during analysis

* true.positive.txt is a text file containing total number of papers with gene name errors from 2014 to 2020.

*There are several files like results2015.txt which is a list of PMC papers. These publications selected upon searching PubMed Central using the keyword "genom".

In the folder "genelist" there are several text files which consist lists of several major organisms which depicts higher rates of erroneous conversions.






