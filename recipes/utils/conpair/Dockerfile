FROM nciccbr/ccbr_ubuntu_base_20.04:v2.0
ENV TAG="v1.0"

# get GATK 3.8-1
WORKDIR /opt2
RUN wget https://storage.googleapis.com/gatk-software/package-archive/gatk/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef.tar.bz2 && \
	tar xjvf GenomeAnalysisTK-3.8-1-0-gf15c1c3ef.tar.bz2 && \
	rm -f GenomeAnalysisTK-3.8-1-0-gf15c1c3ef.tar.bz2
ENV GATK_JAR="/opt2/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar"

# install miniconda
ENV CONDA_DIR /opt2/conda
WORKDIR /opt2
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt2/miniconda.sh && \
  /bin/bash /opt2/miniconda.sh -b -p /opt2/conda
ENV PATH=$CONDA_DIR/bin:$PATH

# install cnvkit
RUN . /opt2/conda/etc/profile.d/conda.sh && \
conda create -n conpair python=2.7 && \
conda activate conpair && \
conda config --add channels defaults && \
conda config --add channels bioconda && \
conda config --add channels conda-forge && \
conda install -y scipy=0.17

# get conpair
RUN git clone https://github.com/nygenome/Conpair.git && \
	cd Conpair && \
	git checkout v0.2

# add wrapper scripts for conpair calls
COPY verify_concordance.py /opt2/verify_concordance.py
RUN chmod a+x /opt2/verify_concordance.py
COPY run_gatk_pileup_for_sample.py /opt2/run_gatk_pileup_for_sample.py
RUN chmod a+x /opt2/run_gatk_pileup_for_sample.py
COPY estimate_tumor_normal_contamination.py /opt2/estimate_tumor_normal_contamination.py
RUN chmod a+x /opt2/estimate_tumor_normal_contamination.py

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
