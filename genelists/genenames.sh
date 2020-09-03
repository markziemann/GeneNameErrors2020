#!/bin/bash

for i in *txt ; do
NAME=`echo $i | cut -d '_' -f1 | sed 's/$/_genes/'`
cut -f3 $i | cut -d ' ' -f1 | sort -u > $NAME
done



#wget ftp://ftp.ensemblgenomes.org/pub/bacteria/release-29/gff3/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/Escherichia_coli_str_k_12_substr_mg1655.GCA_000005845.2.29.gff3.gz
#gunzip Escherichia_coli_str_k_12_substr_mg1655.GCA_000005845.2.29.gff3.gz
awk '$3=="gene"' Escherichia_coli_str_k_12_substr_mg1655.GCA_000005845.2.29.gff3 \
| tr ';' '\n' | grep Name= | cut -d '=' -f2 | sort -u | wc -l > Ecoli_genes
