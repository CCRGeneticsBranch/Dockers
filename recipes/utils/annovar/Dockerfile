FROM nciccbr/ccbr_ubuntu_base_20.04:v2.1
ENV TAG="v1.0"


###########
# ANNOVAR #
###########
# REF: https://github.com/bioinfo-chru-strasbourg/annovar/blob/master/Dockerfile

ENV TOOLS=/opt2
ENV TOOL_NAME=annovar
ENV TOOL_VERSION=current
ENV TARBALL_LOCATION=http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/
ENV TARBALL=annovar.latest.tar.gz
ENV PATH=/opt2/annovar:$PATH
# http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz


# INSTALL
WORKDIR /opt2
RUN wget $TARBALL_LOCATION/$TARBALL ; \
    tar xf $TARBALL --wildcards *pl ; \
    rm -rf $TARBALL
WORKDIR /opt2/annovar/
RUN ln -s /databases/ humandb

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