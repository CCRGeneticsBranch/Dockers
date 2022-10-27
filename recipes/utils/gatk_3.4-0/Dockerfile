FROM nciccbr/ccbr_ubuntu_base_20.04:v2.0
ENV TAG="v1.0"

# source of all jars
# https://console.cloud.google.com/storage/browser/gatk-software/package-archive/gatk;tab=objects?pli=1&prefix=&forceOnObjectsSortingFiltering=false

# get GATK 3.4-0
WORKDIR /opt2
RUN wget https://storage.googleapis.com/gatk-software/package-archive/gatk/GenomeAnalysisTK-3.4-0-g7e26428.tar.bz2 && \
	tar xjvf GenomeAnalysisTK-3.4-0-g7e26428.tar.bz2 && \
	rm -f GenomeAnalysisTK-3.4-0-g7e26428.tar.bz2
ENV GATK_JAR="/opt2/GenomeAnalysisTK.jar"

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
