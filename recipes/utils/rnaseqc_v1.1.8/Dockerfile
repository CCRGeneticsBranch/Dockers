FROM ubuntu:20.04
ENV TAG="v1.0"
RUN mkdir -p /opt2 && mkdir -p /data2
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt-get install -y cpanminus unzip zlibc zlib1g zlib1g-dev bzip2 make gcc g++ wget git curl zip sudo samtools bowtie bwa ttf-dejavu fontconfig
RUN cpanm FindBin Term::ReadLine
# Set the locale
RUN apt-get install -y locales && localedef -i en_US -f UTF-8 en_US.UTF-8

# RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo && chown -R docker:docker /opt2 && chown -R docker:docker /data2

# USER docker

RUN curl -s "https://get.sdkman.io" --output /opt2/getsdkman.bash
ENV SDKMAN_DIR="/opt2/sdk"
RUN bash /opt2/getsdkman.bash
COPY install_java.sh /opt2
RUN bash /opt2/install_java.sh
ENV PATH="$PATH:/opt2/sdk/candidates/java/current/bin"

# RNA-SeQC jar
ADD http://www.broadinstitute.org/cancer/cga/tools/rnaseqc/RNA-SeQC_v1.1.8.jar /opt2
ENV RNASEQCJAR="/opt2/RNA-SeQC_v1.1.8.jar"
RUN chmod a+rX $RNASEQCJAR

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
