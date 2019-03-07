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
        fonts-linuxlibertine \
        tex-gyre \
        tree \
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

# Downgrade pandoc
RUN conda install --yes pandoc=2.4

RUN pip install pandoc-xnos \
        pandoc-eqnos \
        pandoc-fignos \
        pandoc-shortcaption \
        iplantuml \
        matplotlib \
        pweave==0.25

COPY . /usr/local/

USER root

ENV TEXMFHOME=/home/$NB_USER/texmf

RUN mkdir -p $TEXMFHOME/tex/latex/tikzuml/ && \
    wget http://perso.ensta-paristech.fr/~kielbasi/tikzuml/var/files/src/tikzuml-v1.0-2016-03-29.tbz && \
    tar xvjf tikzuml-v1.0-2016-03-29.tbz && \
    mv tikzuml-v1.0-2016-03-29/tikz-uml.sty $TEXMFHOME/tex/latex/tikzuml/

## Install NeurIPS template
RUN mkdir -p $TEXMFHOME/tex/latex/neurips_2018/ && \
    mv /usr/local/pandoc_conference_templates/NeurIPS_2018/*.sty $TEXMFHOME/tex/latex/neurips_2018/

## Install ICML template
RUN mkdir -p $TEXMFHOME/tex/latex/icml_2019/ && \
    mv /usr/local/pandoc_conference_templates/ICML_2019/*.sty $TEXMFHOME/tex/latex/icml_2019/

## Install IEEE template
RUN mkdir -p $TEXMFHOME/tex/latex/ieee/ && \
  cp /usr/local/pandoc_conference_templates/IEEEtran/*.cls $TEXMFHOME/tex/latex/ieee/

## Install ACM CCS
RUN mkdir -p $TEXMFHOME/tex/latex/acmccs/ && \
    mv /usr/local/acmccs/*.cls $TEXMFHOME/tex/latex/acmccs/


RUN mkdir -p $TEXMFHOME/tex/latex/kth/ && \
	wget http://web.student.chalmers.se/~k02hajo/public/Latex/Manualer/KTH%20thesis/kthesis.tar.gz && \
	wget http://web.student.chalmers.se/~k02hajo/public/Latex/Manualer/KTH%20thesis/kthsym.tar.gz && \
  	tar xvzf kthesis.tar.gz -C $TEXMFHOME && \
  	tar xvzf kthsym.tar.gz -C $TEXMFHOME && \
  	wget https://raw.githubusercontent.com/karlkurzer/path_planner_tex/master/KTHEEtitlepage.sty -P $TEXMFHOME/tex/latex/kth/ && \
  	wget https://github.com/karlkurzer/path_planner_tex/raw/master/kth_logo.pdf -P $TEXMFHOME/tex/generic/kthsym

COPY kthcolors/lib/kthcolors.sty $TEXMFHOME/tex/latex/kth/
