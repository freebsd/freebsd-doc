# Generate the FreeBSD documentation
#
# Copyright (c) 2020-2021, The FreeBSD Documentation Project
# Copyright (c) 2020-2021, Sergio Carlavilla <carlavilla@FreeBSD.org>
#
# Targets intended for use on the command line
#
# all (default)	-	generate the books TOC and compile all the documentation
# run	-			serves the built documentation site for local browsing
#
# The run target uses hugo's built-in webserver to make the documentation site
# available for local browsing.  The documentation should have been built prior
# to attempting to use the `run` target.  By default, hugo will start its
# webserver on port 1313.

MAINTAINER=carlavilla@FreeBSD.org

PYTHON_CMD =	/usr/local/bin/python3.7
HUGO_CMD =	/usr/local/bin/hugo
LANGUAGES =	en,es,pt-br,de,ja,zh-cn,zh-tw,ru,el,hu,it,mn,nl,pl,fr

.ORDER: all run

.ORDER: starting-message generate-books-toc
.ORDER: starting-message build
.ORDER: generate-books-toc build

all: starting-message generate-books-toc build
run: starting-message generate-books-toc run-local

starting-message: .PHONY
	@echo ---------------------------------------------------------------
	@echo                   Building the documentation
	@echo ---------------------------------------------------------------

generate-books-toc: .PHONY
	${PYTHON_CMD} ./tools/books-toc-parts-creator.py -l ${LANGUAGES}
	${PYTHON_CMD} ./tools/books-toc-creator.py -l ${LANGUAGES}
	${PYTHON_CMD} ./tools/books-toc-figures-creator.py -l ${LANGUAGES}
	${PYTHON_CMD} ./tools/books-toc-tables-creator.py -l ${LANGUAGES}
	${PYTHON_CMD} ./tools/books-toc-examples-creator.py -l ${LANGUAGES}

run-local: .PHONY
	${HUGO_CMD} server -D

build: .PHONY
	${HUGO_CMD} --minify
