# Generate the FreeBSD documentation
#
# Copyright (c) 2020-2021, The FreeBSD Documentation Project
# Copyright (c) 2020-2021, Sergio Carlavilla <carlavilla@FreeBSD.org>
#
# Targets intended for use on the command line
#
# all (default)	-	generate the books TOC and compile all the documentation
# generate	-	generate the books TOC and build all the documentation
# copy-shared	-	move the shared AsciiDoc entities to the folder project

MAINTAINER=carlavilla@FreeBSD.org

PYTHON_CMD =	/usr/local/bin/python3.7
HUGO_CMD =	/usr/local/bin/hugo
LANGUAGES =	en,es,pt-br,de,ja,zh-cn,zh-tw,ru,el,hu,it,mn,nl,pl,fr

all: starting-message generate-books-toc run
generate: starting-message generate-books-toc build
copy-shared: move-shared

starting-message:
	@echo ---------------------------------------------------------------
	@echo                   Building the documentation
	@echo ---------------------------------------------------------------

generate-books-toc:
	${PYTHON_CMD} ./tools/books-toc-parts-creator.py -l ${LANGUAGES}
	${PYTHON_CMD} ./tools/books-toc-creator.py -l ${LANGUAGES}
	${PYTHON_CMD} ./tools/books-toc-figures-creator.py -l ${LANGUAGES}
	${PYTHON_CMD} ./tools/books-toc-tables-creator.py -l ${LANGUAGES}
	${PYTHON_CMD} ./tools/books-toc-examples-creator.py -l ${LANGUAGES}

run:
	${HUGO_CMD} server -D

build:
	${HUGO_CMD} --minify

move-shared:
	cp -R ../shared ./shared
