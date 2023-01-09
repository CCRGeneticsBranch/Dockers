# FROM nciccbr/ccbr_ubuntu_base_20.04:v2.1
# Using https://github.com/zlskidmore/docker-seq2HLA/blob/master/Dockerfile
FROM ubuntu:18.04
ENV TAG="v1.0"

# set the environment variables
ENV seq2HLA_version 2.3
ENV bowtie_version 0.12.9
ENV r_version 2.12.2
ENV biopython_version 1.58

# run update and install necessary tools from package manager
RUN apt-get update -y && apt-get install -y \
    build-essential \
    cmake \
    zlib1g-dev \
    libhdf5-dev \
    libnss-sss \
    curl \
    git \
    gfortran \
    libreadline-dev \
    libpcre3-dev \
    libbz2-dev \
    liblzma-dev \
    libxml2-dev \
    less \
    vim \
    unzip \
    python2.7-dev \
    python-pip

# Install numpy
RUN pip install numpy

# install correct biopython version
WORKDIR /usr/local/bin
RUN curl -SL http://biopython.org/DIST/biopython-${biopython_version}.tar.gz \
    > ${biopython_version}-1.58.tar.gz
RUN tar -xzvf ${biopython_version}-1.58.tar.gz
WORKDIR /usr/local/bin/biopython-${biopython_version}
RUN python2.7 setup.py build
RUN python2.7 setup.py test
RUN python2.7 setup.py install


# install correct bowtie version
WORKDIR /usr/local/bin
RUN curl -SL https://github.com/BenLangmead/bowtie/archive/v${bowtie_version}.tar.gz \
    > v${bowtie_version}.tar.gz
RUN tar -xzvf v${bowtie_version}.tar.gz
WORKDIR /usr/local/bin/bowtie-${bowtie_version}
RUN make

# install correct R
WORKDIR /usr/local/bin
RUN curl https://cran.r-project.org/src/base/R-2/R-${r_version}.tar.gz \
    > R-${r_version}.tar.gz
RUN tar -zxvf R-${r_version}.tar.gz
WORKDIR /usr/local/bin/R-${r_version}
RUN ./configure --prefix=/usr/local/ --with-x=no
RUN make
RUN make install

# install seq2HLA
WORKDIR /usr/local/bin
RUN curl -SL https://github.com/TRON-Bioinformatics/seq2HLA/archive/master.zip > master.zip
RUN unzip master.zip
WORKDIR /usr/local/bin/seq2HLA-master
RUN mv seq2HLA.py seq2HLA.py.tmp && \
    echo "#!/usr/bin/env python" > seq2HLA.py && \
    cat seq2HLA.py.tmp >> seq2HLA.py && \
    chmod a+x seq2HLA.py && \
    rm -f seq2HLA.py.tmp
ENV PATH=${PATH}:/usr/local/bin/seq2HLA-master:/usr/local/bin/bowtie-0.12.9

COPY Dockerfile /opt2/Dockerfile.${TAG}
RUN if [ -f /opt2/Dockerfile ];then rm -f /opt2/Dockerfile;fi && \
    chmod a+r /opt2/Dockerfile.${TAG} && \
    ln -s Dockerfile.${TAG} /opt2/Dockerfile 
WORKDIR /data2

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

# details
LABEL maintainer="vishal.koparde@nih.gov"
LABEL github_handle="kopardev"
ARG BUILD_DATE
LABEL build_date=$BUILD_DATE