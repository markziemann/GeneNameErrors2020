#!/bin/bash

# the aim of this script is to download all gene names and then see which
# ones get converted to dates in spreadsheets

# Ensembl Genomes · Ensembl Bacteria · Ensembl Protists · Ensembl Fungi
# Ensembl # Plants · Ensembl Metazoa · Ensembl (vertebrates)

# vertebrates
mkdir vertebrates && cd vertebrates

#wget -N -r -np -R "index.html*" ftp://ftp.ensembl.org/pub/release-102/gtf/

rm $(find ftp.ensembl.org/pub/release-102/gtf/ | grep .gtf.gz$ | grep -v 102.gtf.gz)

for GTF in $(find . | grep 102.gtf.gz ) ; do

  ORG=$(echo $GTF | cut -d '/' -f6)
  zcat $GTF | grep -w gene \
  | grep -w gene_name | cut -d '"' -f6 \
  | sed "s/^/${ORG}\t/" | sort -u

done > ../gnames_vertebrates.tsv

cd ..

split -l 2000000 --additional-suffix=.tsv gnames_vertebrates.tsv gnames_vertebrates.frag.


# bacteria

mkdir bacteria && cd bacteria

#wget -N -r -np -R "index.html*" ftp://ftp.ensemblgenomes.org/pub/release-49/bacteria//gtf/

for GTF in $(find ftp.ensemblgenomes.org | grep .gtf.gz ) ; do

  ORG=$(echo $GTF | cut -d '/' -f6)
  zcat $GTF | grep -w gene \
  | grep -w gene_name | cut -d '"' -f4  \
  | sed "s/^/${ORG}\t/"

done > ../gnames_bacteria.tsv

cd ..


# Protists

mkdir protists && cd protists

#wget -N -r -np -R "index.html*" ftp://ftp.ensemblgenomes.org/pub/protists/release-49/gtf/

for GTF in $(find ftp.ensemblgenomes.org | grep .gtf.gz ) ; do

  ORG=$(echo $GTF | cut -d '/' -f6)
  zcat $GTF | grep -w gene \
  | grep -w gene_name | cut -d '"' -f4  \
  | sed "s/^/${ORG}\t/"

done > ../gnames_protists.tsv

cd ..

# Fungi

mkdir fungi && cd fungi

#wget -N -r -np -R "index.html*" ftp://ftp.ensemblgenomes.org/pub/fungi/release-49/gtf/

for GTF in $(find ftp.ensemblgenomes.org | grep .gtf.gz ) ; do

  ORG=$(echo $GTF | cut -d '/' -f6)
  zcat $GTF | grep -w gene \
  | grep -w gene_name | cut -d '"' -f4  \
  | sed "s/^/${ORG}\t/"

done > ../gnames_fungi.tsv

cd ..


# Plants

mkdir plants && cd plants

#wget -N -r -np -R "index.html*" ftp://ftp.ensemblgenomes.org/pub/plants/release-49/gtf/

for GTF in $(find ftp.ensemblgenomes.org | grep .gtf.gz ) ; do

  ORG=$(echo $GTF | cut -d '/' -f6)
  zcat $GTF | grep -w gene \
  | grep -w gene_name | cut -d '"' -f4  \
  | sed "s/^/${ORG}\t/"

done > ../gnames_plants.tsv

cd ..


# Metazoa

mkdir metazoa && cd metazoa

#wget -N -r -np -R "index.html*" ftp://ftp.ensemblgenomes.org/pub/metazoa/release-49/gtf/

for GTF in $(find ftp.ensemblgenomes.org | grep .gtf.gz ) ; do

  ORG=$(echo $GTF | cut -d '/' -f6)
  zcat $GTF | grep -w gene \
  | grep -w gene_name | cut -d '"' -f4  \
  | sed "s/^/${ORG}\t/"

done > ../gnames_metazoa.tsv

cd ..

