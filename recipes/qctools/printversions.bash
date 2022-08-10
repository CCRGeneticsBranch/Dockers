#!/bin/bash
figlet bedops
bedops --version

figlet bedtools
bedtools --version

figlet bcftools
bcftools --version

figlet bowtie
bowtie --version

figlet bowtie2
bowtie2 --version

figlet bwa
bwa

figlet java
java -version

figlet javac
javac -version

figlet samtools
samtools --version

figlet vcftools
vcftools --version

figlet R
R --version

figlet python3
python3 --version

figlet python libraries
python3 -c "import argparse;print('argparse:%s'%(argparse.__version__))"
python3 -c "import numpy;print('numpy:%s'%(numpy.__version__))"
python3 -c "import scipy;print('scipy:%s'%(scipy.__version__))"
python3 -c "import pysam;print('pysam:%s'%(pysam.__version__))"

figlet fastqc
fastqc -v

figlet picard
java -jar $PICARDJAR -h 
echo "2.27.4"