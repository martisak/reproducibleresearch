# Reproducible Research

[![license](https://img.shields.io/badge/license-CC%20BY%20SA%203.0-blue.svg)](https://github.com/martisak/reproducibleresearch#licensing)
[![GitHub contributors](https://img.shields.io/github/contributors/martisak/reproducible.svg)](https://github.com/martisak/reproducibleresearch/graphs/contributors)
[![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/martisak/reproducible.svg)](https://github.com/martisak/reproducibleresearch/pulls?q=is%3Apr+is%3Aclosed)
![docker pulls](https://img.shields.io/docker/pulls/martisak/reproducibleresearch.svg) ![docker stars](https://img.shields.io/docker/stars/martisak/reproducibleresearch.svg) [![](https://images.microbadger.com/badges/image/martisak/reproducibleresearch.svg)](https://microbadger.com/images/martisak/reproducibleresearch "martisak/reproducibleresearch image metadata")


A Docker container for building documents.

## Usage

### Pull image

```
docker pull 
```

### Setup bash

Add this to your bash profile

```
render() { docker run -it -v`pwd`:/data martisak make -C /data $@; }
```

### Render

Try this simple example first.

```
git pull git@github.com:martisak/article.git
cd article/example
render
```

The output is written to `example.pdf`.

## Included projects
### CSL Style Repository

[github.com/citation-style-language/styles](https://github.com/citation-style-language/styles) is the official repository for Citation Style Language (CSL) styles and is maintained by CSL project members.
For more information, check out [CitationStyles.org](http://citationstyles.org/) and the [repository wiki](https://github.com/citation-style-language/styles/wiki).

### Classic article template

[Classic article template](https://github.com/martisak/article) is a LaTeX/pandoc theme using [ClassicThesis](https://ctan.org/tex-archive/macros/latex/contrib/classicthesis?lang=en) and [arsclassica](https://www.ctan.org/pkg/arsclassica).

## Licensing

All the styles in this repository are released under the [Creative Commons Attribution-ShareAlike 3.0 Unported license](http://creativecommons.org/licenses/by-sa/3.0/). For attribution, any software using this repository must include a clear mention of the project and a link.

