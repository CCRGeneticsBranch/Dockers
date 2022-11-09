FROM nciccbr/ccbr_ubuntu_base_20.04:v1.4

ENV STAR_VERSION 2.7.10a
ENV RSEM_VERSION 1.3.3
ENV ARRIBA_VERSION 2.3.0
ENV STARFUSION_VERSION 1.11.1

# install star
WORKDIR /opt2
RUN wget --no-check-certificate https://github.com/alexdobin/STAR/archive/${STAR_VERSION}.tar.gz && \
    tar -xzf ${STAR_VERSION}.tar.gz && \
    rm -f ${STAR_VERSION}.tar.gz && \
    cd /opt2/STAR-${STAR_VERSION}/source && \
    make STAR
ENV PATH=/opt2/STAR-${STAR_VERSION}/source:$PATH

# install rsem
WORKDIR /opt2
RUN wget --no-check-certificate https://github.com/deweylab/RSEM/archive/refs/tags/v${RSEM_VERSION}.tar.gz && \
    tar -xzf v${RSEM_VERSION}.tar.gz && \
    rm -f v${RSEM_VERSION}.tar.gz && \
    cd /opt2/RSEM-${RSEM_VERSION} && \
    make && make ebseq
ENV PATH=/opt2/RSEM-${RSEM_VERSION}:$PATH

# install arriba
WORKDIR /opt2
RUN wget --no-check-certificate https://github.com/suhrig/arriba/releases/download/v${ARRIBA_VERSION}/arriba_v${ARRIBA_VERSION}.tar.gz && \
    tar -xzf arriba_v${ARRIBA_VERSION}.tar.gz && \
    rm -f arriba_v${ARRIBA_VERSION}.tar.gz && \
    cd /opt2/arriba_v${ARRIBA_VERSION} && \
    make
ENV PATH=/opt2/arriba_v${ARRIBA_VERSION}:$PATH

# arriba dependencies
RUN apt-get update && \
    apt-get -y install libcurl4-openssl-dev libxml2 libxml2-dev
WORKDIR /opt2
COPY dependencies.R /opt2
RUN Rscript dependencies.R

# install star fusion
WORKDIR /opt2
COPY dependencies_starfusion.R /opt2/
RUN Rscript dependencies_starfusion.R
RUN wget --no-check-certificate https://github.com/STAR-Fusion/STAR-Fusion/releases/download/STAR-Fusion-v${STARFUSION_VERSION}/STAR-Fusion-v${STARFUSION_VERSION}.FULL.tar.gz && \
    tar -xzvf STAR-Fusion-v${STARFUSION_VERSION}.FULL.tar.gz && \
    rm -f STAR-Fusion-v${STARFUSION_VERSION}.FULL.tar.gz && \
    cd /opt2/STAR-Fusion-v${STARFUSION_VERSION} && \
    make
ENV PATH=/opt2/STAR-Fusion-v${STARFUSION_VERSION}:$PATH

# cleanup etc
COPY Dockerfile /opt2/Dockerfile
RUN chmod a+rX /opt2/Dockerfile
WORKDIR /data2
RUN apt-get clean

# details
LABEL maintainer="vishal.koparde@nih.gov"
LABEL github_handle="kopardev"
ARG BUILD_DATE
LABEL build_date=$BUILD_DATE