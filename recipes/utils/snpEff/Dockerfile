FROM nciccbr/ccbr_ubuntu_base_20.04:v2.1
ENV TAG="v1.0"

# get snpeff
WORKDIR /opt2
RUN wget -O snpEff_v4_3t_core.zip https://sourceforge.net/projects/snpeff/files/snpEff_v4_3t_core.zip/download && \
    unzip snpEff_v4_3t_core.zip && \
    rm -f snpEff_v4_3t_core.zip
WORKDIR /opt2/snpEff
RUN java -jar snpEff.jar download GRCh38.86 && \
    java -jar snpEff.jar download GRCh37.75

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
