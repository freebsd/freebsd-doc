# Generate the FreeBSD documentation
#
# Copyright (c) 2020-2025, The FreeBSD Documentation Project
# Copyright (c) 2020-2025, Sergio Carlavilla <carlavilla@FreeBSD.org>
#
# Targets intended for use on the command line
#
# all (default)	-	generate books and articles without generating the
#				PDFs or EPUBs
# clean		- 	removes generated files
# run		-	serves the built documentation site for local browsing
# pdf		-	build PDF versions of the articles and books.
# html		-	build HTML versions of the articles and books for
#				offline use.
#				If variable DOC_HTML_ARCHIVE is set, all documents will be
#				archived/compressed, and only these files will be kept in the
#				public directory.
# epub		-	build EPUB versions of the articles and books (Experimental).
#
# The run target uses hugo's built-in webserver to make the documentation site
# available for local browsing.  The documentation should have been built prior
# to attempting to use the `run` target.  By default, hugo will start its
# webserver on port 1313.

MAINTAINER=carlavilla@FreeBSD.org

# List of languages without book translations
ARTICLEONLY_LANGS=	bn-bd da id ko tr
# List of languages without article translations
BOOKONLY_LANGS=		mn

# List of all languages we have content for
ALL_LANGUAGES=	bn-bd da de el en es fr hu id it ja ko mn nl pl pt-br ru tr zh-cn zh-tw

LOCALBASE?=	/usr/local
USE_RUBYGEMS?=	NO
GEM_PATH?=

.if ${USE_RUBYGEMS} == "YES"
GEMBASE?= 	${GEM_PATH}
.else
GEMBASE?= 	${LOCALBASE}
.endif

RUBY_CMD ?=	${LOCALBASE}/bin/ruby
HUGO_CMD =	${LOCALBASE}/bin/hugo
HUGO_ARGS?=	--minify
HUGO_OFFLINE_ARGS?= 	--environment offline --minify
ROUGIFY_CMD=	${GEMBASE}/bin/rougify
ASCIIDOCTOR_CMD=	${GEMBASE}/bin/asciidoctor
ASCIIDOCTORPDF_CMD=	${GEMBASE}/bin/asciidoctor-pdf
ASCIIDOCTOREPUB3_CMD= ${GEMBASE}/bin/asciidoctor-epub3

.if defined(DOC_LANG) && !empty(DOC_LANG)
LANGUAGES=	${DOC_LANG:S/,/ /g}
.if  ${LANGUAGES:Men} == "" && ${.TARGETS:Mpdf*} == "" && ${.TARGETS:Mhtml*} == ""
.warning "Warning: cannot skip 'en'; adding it back"
LANGUAGES+=	en
.endif
.else
LANGUAGES=	${ALL_LANGUAGES}
.endif

RUBYLIB =	../shared/lib
.export	RUBYLIB

RUN_DEPENDS=	${HUGO_CMD} \
				${ASCIIDOCTOR_CMD} \
				${ROUGIFY_CMD}

.ifndef HOSTNAME
.  ifdef BIND
.HOST=$(BIND)
.  else
.HOST=localhost
.  endif
.else
.HOST=$(HOSTNAME)
.endif

# Strip the languages with only articles from the list of languages we
#  will use to build books.
BOOK_LANGS= ${LANGUAGES}
.for a in ${ARTICLEONLY_LANGS}
BOOK_LANGS:=	${BOOK_LANGS:N${a}}
.endfor

# Strip the languages with only books from the list of languages we
#  will use to build articles.
ARTICLE_LANGS= ${LANGUAGES}
.for a in ${BOOKONLY_LANGS}
ARTICLE_LANGS:=	${ARTICLE_LANGS:N${a}}
.endfor

# Take the list of all languages, and take out the ones we have been
#   asked for.  We'll feed this to hugo.
SKIP_LANGS=
.for a in ${ALL_LANGUAGES}
.if  ${LANGUAGES:M${a}} == ""
SKIP_LANGS+=    ${a}
.endif
.endfor

.ORDER: all run

.ORDER: requirements
.ORDER: starting-message
.ORDER: starting-message build
.ORDER: build

all: requirements starting-message generate-pgpkeys-txt build
run: requirements starting-message generate-pgpkeys-txt run-local

# clean does not call pdf-clean as that is a subset of hugo-clean
clean: hugo-clean pgp-clean

requirements:
.for dep in ${RUN_DEPENDS}
.if !exists(${dep})
	@(echo ${dep} not found, please run 'pkg install docproj'; exit 1)
.endif
.endfor

requirements-pdf:
.if !exists(${ASCIIDOCTORPDF_CMD})
	@(echo ${ASCIIDOCTOR_CMD} not found, please install rubygem-asciidoctor-pdf; exit 1)
.endif

requirements-epub:
.if !exists(${ASCIIDOCTOREPUB3_CMD})
	@(echo ${ASCIIDOCTOREPUB3_CMD} not found, please install rubygem-asciidoctor-epub3; exit 1)
.endif

starting-message: .PHONY
	@echo ---------------------------------------------------------------
	@echo                   Building the documentation
	@echo  included languages: ${LANGUAGES}
	@echo  excluded languages: ${SKIP_LANGS}
	@echo ---------------------------------------------------------------

generate-pgpkeys-txt: static/pgpkeys/pgpkeys.txt

static/pgpkeys/pgpkeys.txt: static/pgpkeys/*key
	${RUBY_CMD} ./tools/global-pgpkeys-creator.rb

run-local: .PHONY
	HUGO_DISABLELANGUAGES="${SKIP_LANGS}" ${HUGO_CMD} server \
		${HUGO_ARGS} -D $(BIND:D--bind=$(BIND)) --baseURL="http://$(.HOST):1313"

build: .PHONY
	HUGO_DISABLELANGUAGES="${SKIP_LANGS}" ${HUGO_CMD} ${HUGO_ARGS}

build-offline: .PHONY
	HUGO_DISABLELANGUAGES="${SKIP_LANGS}" ${HUGO_CMD} ${HUGO_OFFLINE_ARGS}

pgp-clean: .PHONY
	rm -f static/pgpkeys/pgpkeys.txt

hugo-clean: .PHONY
	rm -rf resources public

#
# PDF targets
# Use DOC_LANG to choose the language, e.g., make DOC_LANG="en fr" pdf-books
#
pdf: pdf-articles pdf-books

pdf-books: requirements-pdf
.for _lang in ${BOOK_LANGS}
	./tools/asciidoctor.sh books ${_lang} pdf
.endfor

pdf-articles: requirements-pdf
.for _lang in ${ARTICLE_LANGS}
	./tools/asciidoctor.sh articles ${_lang} pdf
.endfor

pdf-clean: pdf-articles-clean pdf-books-clean

pdf-books-clean:
.for _lang in ${BOOK_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/books
	-rmdir ${.CURDIR}/public/${_lang}
.endfor
	-rmdir ${.CURDIR}/public/

pdf-articles-clean:
.for _lang in ${ARTICLE_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/articles
.if !exists(${.CURDIR}/public/${_lang}/books)
	rm -fr ${.CURDIR}/public/${_lang}
.endif
.endfor
	-rmdir ${.CURDIR}/public

#
# HTML targets
#
html: build-offline html-clean-global html-clean-articles html-clean-books html-archive html-archive-clean-files

html-clean: hugo-clean

html-clean-global:
	rm -fr ${.CURDIR}/public/index.html
	rm -rf pgpkeys js

html-clean-articles:
.for _lang in ${ARTICLE_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/index.html
	rm -fr ${.CURDIR}/public/${_lang}/articles/index.html
.endfor

html-clean-books:
.for _lang in ${BOOK_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/books/index.html
.endfor

html-archive:
.if defined(DOC_HTML_ARCHIVE)
.for _lang in ${ARTICLE_LANGS}
	./tools/asciidoctor.sh articles ${_lang} archive
.endfor
.for _lang in ${BOOK_LANGS}
	./tools/asciidoctor.sh books ${_lang} archive
.endfor
.endif

html-archive-clean-files:
.if defined(DOC_HTML_ARCHIVE)
	find ${.CURDIR}/public/ ! -name '*.pdf' ! -name '*.tar.gz' -type f -delete
	find ${.CURDIR}/public/ -type d -empty -delete
.endif

#
# EPUB targets
# Use DOC_LANG to choose the language, e.g., make DOC_LANG="en fr" epub-books
#
epub: epub-articles epub-books

epub-books: requirements-epub
	@echo ---------------------------------------------------------------
	@echo !!! EPUB output is experimental !!!
	@echo
	@echo Asciidoctor EPUB3 is currently alpha software. Use accordingly. Although the
	@echo bulk of AsciiDoc content is converted, there’s still work needed to fill in
	@echo gaps where conversion is incomplete or unstyled.
	@echo https://docs.asciidoctor.org/epub3-converter/latest/#project-status
	@echo ---------------------------------------------------------------
.for _lang in ${BOOK_LANGS}
	./tools/asciidoctor.sh books ${_lang} epub
.endfor

epub-articles: requirements-epub
	@echo ---------------------------------------------------------------
	@echo !!! EPUB output is experimental !!!
	@echo
	@echo Asciidoctor EPUB3 is currently alpha software. Use accordingly. Although the
	@echo bulk of AsciiDoc content is converted, there’s still work needed to fill in
	@echo gaps where conversion is incomplete or unstyled.
	@echo https://docs.asciidoctor.org/epub3-converter/latest/#project-status
	@echo ---------------------------------------------------------------
.for _lang in ${ARTICLE_LANGS}
	./tools/asciidoctor.sh articles ${_lang} epub
.endfor

epub-clean: epub-articles-clean epub-books-clean

epub-books-clean:
.for _lang in ${BOOK_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/books
	-rmdir ${.CURDIR}/public/${_lang}
.endfor
	-rmdir ${.CURDIR}/public/

epub-articles-clean:
.for _lang in ${ARTICLE_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/articles
.if !exists(${.CURDIR}/public/${_lang}/books)
	rm -fr ${.CURDIR}/public/${_lang}
.endif
.endfor
	-rmdir ${.CURDIR}/public

