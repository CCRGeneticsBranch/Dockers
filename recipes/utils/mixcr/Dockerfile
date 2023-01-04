FROM nciccbr/ccbr_ubuntu_base_20.04:v2.0
ENV TAG="v1.0"

# install miniconda
ENV CONDA_DIR /opt2/conda
WORKDIR /opt2
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt2/miniconda.sh && \
  /bin/bash /opt2/miniconda.sh -b -p /opt2/conda
ENV PATH=$CONDA_DIR/bin:$PATH

# install cnvkit
RUN . /opt2/conda/etc/profile.d/conda.sh && \
conda create -n mixcr && \
conda activate mixcr && \
conda install -c milaboratories mixcr=4.1.2 --no-deps

# add wrapper scripts for conpair calls
COPY mixcr /opt2/mixcr
RUN chmod a+x /opt2/mixcr

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

# details
LABEL maintainer="vishal.koparde@nih.gov"
LABEL github_handle="kopardev"
ARG BUILD_DATE
LABEL build_date=$BUILD_DATE
