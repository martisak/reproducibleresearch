FROM jupyter/r-notebook
MAINTAINER Martin Isaksson <martin.isaksson@gmail.com>
USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt install -y \
        software-properties-common \
        apt-transport-https \
        texlive-publishers \
        texlive-math-extra \
        ttf-adf-gillius && \
    add-apt-repository multiverse && \
    apt-get update

RUN wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.1/misc/FontPack910_xtd_i486-linux.tar.bz2 && \
    tar xvjf FontPack910_xtd_i486-linux.tar.bz2 && \
    tar xvf xtdfont/XTDFONT.TAR && \
    mv Adobe/Reader9/Resource/Font/*.otf /usr/share/fonts/opentype && \
    fc-cache

RUN pip install pandoc-eqnos \
        pandoc-fignos

COPY . /usr/local/
