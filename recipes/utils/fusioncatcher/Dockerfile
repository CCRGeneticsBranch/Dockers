FROM nciccbr/ccbr_ubuntu_base_20.04:v2.0
ENV TAG="v1.0"

# install miniconda
ENV CONDA_DIR /opt2/conda
WORKDIR /opt2
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt2/miniconda.sh && \
  /bin/bash /opt2/miniconda.sh -b -p /opt2/conda
ENV PATH=$CONDA_DIR/bin:$PATH

# install fusioncatcher
RUN . /opt2/conda/etc/profile.d/conda.sh && \
conda config --add channels defaults && \
conda config --add channels bioconda && \
conda config --add channels conda-forge && \
conda create -n fusioncatcher fusioncatcher

# download human data
#RUN . /opt2/conda/etc/profile.d/conda.sh && \
#conda activate fusioncatcher && \
#download-human-db.sh

WORKDIR /opt2

# create wrapper for mimseq conda env
COPY fusioncatcher /opt2
RUN chmod a+x /opt2/fusioncatcher

# tagging
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
