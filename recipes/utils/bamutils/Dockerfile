FROM nciccbr/ccbr_ubuntu_base_20.04:v2.0
ENV TAG="v1.0"

WORKDIR /tmp
RUN git clone https://github.com/statgen/bamUtil.git && \
    && cd bamUtil && make cloneLib && make && make install INSTALLDIR=/opt2/bamUtil
ENV PATH="$PATH:/opt2/bamUtil"
RUN rm -rf /tmp/bamUtil

# tagging
COPY Dockerfile.${TAG} /opt2/Dockerfile.${TAG}
COPY printversions.bash /opt2/printversions
RUN if [ -f /opt2/Dockerfile ];then rm -f /opt2/Dockerfile;fi && \
    chmod a+r /opt2/Dockerfile.${TAG} && \
    ln -s Dockerfile.${TAG} /opt2/Dockerfile && \
    chmod a+rx /opt2/printversions
RUN /opt2/printversions > /opt2/versions.txt; exit 0
RUN chmod a+r /opt2/versions.txt
WORKDIR /data2

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/