FROM nciccbr/ccbr_ubuntu_base_20.04:v2.1
ENV TAG="v1.0"

# get HLAminer
RUN cpanm Bio::SearchIO
WORKDIR /opt2
RUN wget https://github.com/bcgsc/HLAminer/releases/download/v1.4/HLAminer_1-4.tar.gz && \
    tar xzvf HLAminer_1-4.tar.gz && rm -f HLAminer_1-4.tar.gz
ENV PATH="$PATH:/opt2/HLAminer-1.4/HLAminer_v1.4/bin"

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
