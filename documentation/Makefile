# Generate the FreeBSD documentation
#
# Copyright (c) 2020-2021, The FreeBSD Documentation Project
# Copyright (c) 2020-2021, Sergio Carlavilla <carlavilla@FreeBSD.org>
#
# Targets intended for use on the command line
#
# all (default)	-	generate the books TOC and compile all the documentation
# run		-	serves the built documentation site for local browsing
# pdf		-	build PDF versions of the articles and books.
#
# The run target uses hugo's built-in webserver to make the documentation site
# available for local browsing.  The documentation should have been built prior
# to attempting to use the `run` target.  By default, hugo will start its
# webserver on port 1313.

MAINTAINER=carlavilla@FreeBSD.org

# List of languages without book translations
ARTICLEONLY_LANGS=	bd da ko tr

LOCALBASE?=	/usr/local

PYTHON_CMD =	${LOCALBASE}/bin/python3
RUBY_CMD =	${LOCALBASE}/bin/ruby
HUGO_CMD =	${LOCALBASE}/bin/hugo
HUGO_ARGS?=	--verbose --minify
ASCIIDOCTORPDF_CMD=	${LOCALBASE}/bin/asciidoctor-pdf
.if defined(DOC_LANG) && !empty(DOC_LANG)
LANGUAGES=	${DOC_LANG:S/,/ /g}
.else
LANGUAGES=	bd da de el en es fr hu it ja ko mn nl pl pt-br ru tr zh-cn zh-tw
.endif

RUBYLIB =	../shared/lib
.export	RUBYLIB

RUN_DEPENDS=	${PYTHON_CMD} \
		${HUGO_CMD} \
		${LOCALBASE}/bin/asciidoctor \
		${LOCALBASE}/bin/asciidoctor-pdf \
		${LOCALBASE}/bin/rougify

.ifndef HOSTNAME
.  ifdef BIND
.HOST=$(BIND)
.  else
.HOST=localhost
.  endif
.else
.HOST=$(HOSTNAME)
.endif

# Strip the languages without articles from the list of languages we
#  will use to build books.
BOOK_LANGS= ${LANGUAGES}
.for a in ${ARTICLEONLY_LANGS}
BOOK_LANGS:=	${BOOK_LANGS:N${a}}
.endfor

.ORDER: all run

.ORDER: requirements
.ORDER: starting-message generate-books-toc
.ORDER: starting-message build
.ORDER: generate-books-toc build

all: requirements starting-message generate-books-toc generate-pgpkeys-txt build
run: requirements starting-message generate-books-toc generate-pgpkeys-txt run-local

requirements:
.for dep in ${RUN_DEPENDS}
.if !exists(${dep})
	@(echo ${dep} not found, please run 'pkg install docproj'; exit 1)
.endif
.endfor

starting-message: .PHONY
	@echo ---------------------------------------------------------------
	@echo                   Building the documentation
	@echo ---------------------------------------------------------------

generate-books-toc: .PHONY
	${PYTHON_CMD} ./tools/books-toc-parts-creator.py -l    ${BOOK_LANGS}
	${PYTHON_CMD} ./tools/books-toc-creator.py -l          ${BOOK_LANGS}
	${PYTHON_CMD} ./tools/books-toc-figures-creator.py -l  ${BOOK_LANGS}
	${PYTHON_CMD} ./tools/books-toc-tables-creator.py -l   ${BOOK_LANGS}
	${PYTHON_CMD} ./tools/books-toc-examples-creator.py -l ${BOOK_LANGS}

generate-pgpkeys-txt: static/pgpkeys/pgpkeys.txt

static/pgpkeys/pgpkeys.txt: static/pgpkeys/*key
	${RUBY_CMD} ./tools/global-pgpkeys-creator.rb

run-local: .PHONY
	${HUGO_CMD} server ${HUGO_ARGS} -D $(BIND:D--bind=$(BIND)) --baseURL="http://$(.HOST):1313"

build: .PHONY
	${HUGO_CMD} ${HUGO_ARGS}

#
# PDF targets
# Use DOC_LANG to choose the language, e.g., make DOC_LANG="en fr" pdf-books
#
pdf: pdf-articles pdf-books

pdf-books-target:
.for _lang in ${LANGUAGES:S|,| |g}
.if exists(${.CURDIR}/content/${_lang}/books/)
TMP += ${.CURDIR}/content/${_lang}/books/*/
.endif
.endfor
BOOKSDIR != echo ${TMP}

pdf-articles-target:
.for _lang in ${LANGUAGES:S|,| |g}
.if exists(${.CURDIR}/content/${_lang}/articles/)
TTMP += ${.CURDIR}/content/${_lang}/articles/*/
.endif
.endfor
ARTICLESDIR != echo ${TTMP}

pdf-books: pdf-books-target generate-books-toc

# Books build
#
# Notes:
# pdf-theme=default-with-fallback-font is
# used instead of pdf-theme=./themes/default-pdf-theme.yml because
# it allows ja, ru, tr, zh-* fonts to be embedded and rendering is
# better for other languages.
#
# asciidoctor-pdf-cjk and/or specific themes should be used for cjk
# fonts
.for _curpdf in ${BOOKSDIR}
	@mkdir -p ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}
.if exists(${_curpdf}book.adoc)
	${ASCIIDOCTORPDF_CMD} \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/git-macro.rb \
	-r ./shared/lib/packages-macro.rb \
	-r ./shared/lib/inter-document-references-macro.rb \
	-r ./shared/lib/sectnumoffset-treeprocessor.rb \
	--doctype=book \
	-a skip-front-matter \
	-a pdf-theme=default-with-fallback-font \
	-o ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}book.pdf \
	${_curpdf}book.adoc
.else
# some books use _index.adoc as main document
	${ASCIIDOCTORPDF_CMD} \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/git-macro.rb \
	-r ./shared/lib/packages-macro.rb \
	-r ./shared/lib/inter-document-references-macro.rb \
	-r ./shared/lib/sectnumoffset-treeprocessor.rb \
	--doctype=book \
	-a skip-front-matter \
	-a pdf-theme=default-with-fallback-font \
	-o ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}book.pdf \
	${_curpdf}_index.adoc
.endif
.endfor

pdf-articles: pdf-articles-target

# Articles build
.for _curpdf in ${ARTICLESDIR}
	@mkdir -p ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}
	${ASCIIDOCTORPDF_CMD} \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/git-macro.rb \
	-r ./shared/lib/packages-macro.rb \
	-r ./shared/lib/inter-document-references-macro.rb \
	-r ./shared/lib/sectnumoffset-treeprocessor.rb \
	--doctype=article \
	-a skip-front-matter \
	-a pdf-theme=default-with-fallback-font \
	-o ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}article.pdf \
	${_curpdf}_index.adoc
.if exists(${.CURDIR}/static/source/articles/${_curpdf:H:T})
	cp -R ${.CURDIR}/static/source/articles/${_curpdf:H:T}/ \
		${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}
.endif
.endfor

pdf-clean: pdf-articles-clean pdf-books-clean

pdf-books-clean: pdf-books-target
.for _curpdf in ${BOOKSDIR}
	rm -f ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}book.pdf ${_curpdf}toc*.adoc
	rm -fr ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}
.endfor
.for _lang in ${LANGUAGES:S|,| |g}
	rm -fr ${.CURDIR}/public/${_lang}/books
.if !exists(${.CURDIR}/public/${_lang}/articles)
	rm -fr ${.CURDIR}/public/${_lang}
.endif
.endfor
	@if [ -d ${.CURDIR}/public/ ]; then \
		if [ -z "`ls -A ${.CURDIR}/public/`" ]; then \
			rm -fr ${.CURDIR}/public; \
		fi;	\
	fi

pdf-articles-clean: pdf-articles-target
.for _curpdf in ${ARTICLESDIR}
	rm -f ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}article.pdf
	rm -fr ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}
.endfor
.for _lang in ${LANGUAGES:S|,| |g}
	rm -fr ${.CURDIR}/public/${_lang}/articles
.if !exists(${.CURDIR}/public/${_lang}/books)
	rm -fr ${.CURDIR}/public/${_lang}
.endif
.endfor
	@if [ -d ${.CURDIR}/public/ ]; then \
		if [ -z "`ls -A ${.CURDIR}/public/`" ]; then \
			rm -fr ${.CURDIR}/public; \
		fi;	\
	fi
