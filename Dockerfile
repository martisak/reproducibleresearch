FROM jupyter/r-notebook
MAINTAINER Martin Isaksson <martin.isaksson@gmail.com>
USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        apt-transport-https \
        texlive-publishers \
        texlive-science \
        texlive-lang-european \
        ttf-adf-gillius \
        tex-gyre \
        plantuml \
        python-pip && \
    add-apt-repository multiverse && \
    apt-get update

RUN cd /tmp && \
    mkdir -p /usr/share/fonts/opentype && \
    wget http://download.adobe.com/pub/adobe/reader/unix/9.x/9.1/misc/FontPack910_xtd_i486-linux.tar.bz2 && \
    tar xvjf FontPack910_xtd_i486-linux.tar.bz2 && \
    tar xvf xtdfont/XTDFONT.TAR && \
    mv Adobe/Reader9/Resource/Font/*.otf /usr/share/fonts/opentype && \
    fc-cache && \
    cd

RUN pip install pandoc-xnos \
        pandoc-eqnos \
        pandoc-fignos \
        pandoc-shortcaption \
        iplantuml \
        pweave

COPY . /usr/local/

USER root

ENV TEXMFHOME=/home/$NB_USER/texmf

RUN mkdir -p $TEXMFHOME/tex/latex/kth/ && \
	wget http://web.student.chalmers.se/~k02hajo/public/Latex/Manualer/KTH%20thesis/kthesis.tar.gz && \
	wget http://web.student.chalmers.se/~k02hajo/public/Latex/Manualer/KTH%20thesis/kthsym.tar.gz && \
  	tar xvzf kthesis.tar.gz -C $TEXMFHOME && \
  	tar xvzf kthsym.tar.gz -C $TEXMFHOME && \
  	wget https://raw.githubusercontent.com/karlkurzer/path_planner_tex/master/KTHEEtitlepage.sty -P $TEXMFHOME/tex/latex/kth/ && \
  	wget https://github.com/karlkurzer/path_planner_tex/raw/master/kth_logo.pdf -P $TEXMFHOME/tex/generic/kthsym

COPY kthcolors/lib/kthcolors.sty $TEXMFHOME/tex/latex/kth/
