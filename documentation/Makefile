# Generate the FreeBSD documentation
#
# Copyright (c) 2020-2021, The FreeBSD Documentation Project
# Copyright (c) 2020-2021, Sergio Carlavilla <carlavilla@FreeBSD.org>
#
# Targets intended for use on the command line
#
# all (default)	-	generate the books TOC and compile all the documentation
# clean		- 	removes generated files
# run		-	serves the built documentation site for local browsing
# pdf		-	build PDF versions of the articles and books.
# html		-	build HTML versions of the articles and books for
# offline use
#
# The run target uses hugo's built-in webserver to make the documentation site
# available for local browsing.  The documentation should have been built prior
# to attempting to use the `run` target.  By default, hugo will start its
# webserver on port 1313.

MAINTAINER=carlavilla@FreeBSD.org

# List of languages without book translations
ARTICLEONLY_LANGS=	bd da ko tr
# List of languages without article translations
BOOKONLY_LANGS=		mn

# List of all languages we have content for
ALL_LANGUAGES=	bd da de el en es fr hu it ja ko mn nl pl pt-br ru tr zh-cn zh-tw

LOCALBASE?=	/usr/local

PYTHON_CMD =	${LOCALBASE}/bin/python3
RUBY_CMD =	${LOCALBASE}/bin/ruby
HUGO_CMD =	${LOCALBASE}/bin/hugo
HUGO_ARGS?=	--verbose --minify
ASCIIDOCTOR_CMD=	${LOCALBASE}/bin/asciidoctor
ASCIIDOCTORPDF_CMD=	${LOCALBASE}/bin/asciidoctor-pdf
SED_CMD =	/usr/bin/sed
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
.ORDER: starting-message generate-books-toc
.ORDER: starting-message build
.ORDER: generate-books-toc build

all: requirements starting-message generate-books-toc generate-pgpkeys-txt build
run: requirements starting-message generate-books-toc generate-pgpkeys-txt run-local

# clean does not call pdf-clean as that is a subset of hugo-clean
clean: hugo-clean pgp-clean toc-clean

requirements:
.for dep in ${RUN_DEPENDS}
.if !exists(${dep})
	@(echo ${dep} not found, please run 'pkg install docproj python3'; exit 1)
.endif
.endfor

starting-message: .PHONY
	@echo ---------------------------------------------------------------
	@echo                   Building the documentation
	@echo  included languages: ${LANGUAGES}
	@echo  excluded languages: ${SKIP_LANGS}
	@echo ---------------------------------------------------------------

generate-books-toc: .PHONY
.if !empty(BOOK_LANGS)
	${PYTHON_CMD} ./tools/books-toc-parts-creator.py -l    ${BOOK_LANGS}
	${PYTHON_CMD} ./tools/books-toc-creator.py -l          ${BOOK_LANGS}
	${PYTHON_CMD} ./tools/books-toc-figures-creator.py -l  ${BOOK_LANGS}
	${PYTHON_CMD} ./tools/books-toc-tables-creator.py -l   ${BOOK_LANGS}
	${PYTHON_CMD} ./tools/books-toc-examples-creator.py -l ${BOOK_LANGS}
.endif

generate-pgpkeys-txt: static/pgpkeys/pgpkeys.txt

static/pgpkeys/pgpkeys.txt: static/pgpkeys/*key
	${RUBY_CMD} ./tools/global-pgpkeys-creator.rb

run-local: .PHONY
	HUGO_DISABLELANGUAGES="${SKIP_LANGS}" ${HUGO_CMD} server \
		${HUGO_ARGS} -D $(BIND:D--bind=$(BIND)) --baseURL="http://$(.HOST):1313"

build: .PHONY
	HUGO_DISABLELANGUAGES="${SKIP_LANGS}" ${HUGO_CMD} ${HUGO_ARGS}

toc-clean: .PHONY
.if !empty(BOOK_LANGS)
	rm -f $$(${PYTHON_CMD} ./tools/books-toc-parts-creator.py    -l ${BOOK_LANGS} -o)
	rm -f $$(${PYTHON_CMD} ./tools/books-toc-creator.py          -l ${BOOK_LANGS} -o)
	rm -f $$(${PYTHON_CMD} ./tools/books-toc-figures-creator.py  -l ${BOOK_LANGS} -o)
	rm -f $$(${PYTHON_CMD} ./tools/books-toc-tables-creator.py   -l ${BOOK_LANGS} -o)
	rm -f $$(${PYTHON_CMD} ./tools/books-toc-examples-creator.py -l ${BOOK_LANGS} -o)
.endif

pgp-clean: .PHONY
	rm -f static/pgpkeys/pgpkeys.txt

hugo-clean: .PHONY
	rm -rf resources public

#
# PDF targets
# Use DOC_LANG to choose the language, e.g., make DOC_LANG="en fr" pdf-books
#
pdf: pdf-articles pdf-books

pdf-books-target:
.for _lang in ${BOOK_LANGS}
TMP+= ${.CURDIR}/content/${_lang}/books/*/
.endfor
BOOKSDIR != echo ${TMP}

pdf-articles-target:
.for _lang in ${ARTICLE_LANGS}
TTMP += ${.CURDIR}/content/${_lang}/articles/*/
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

pdf-books-clean: pdf-books-target toc-clean
.for _curpdf in ${BOOKSDIR}
	rm -f ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}book.pdf
.endfor
.for _lang in ${BOOK_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/books
	-rmdir ${.CURDIR}/public/${_lang}
.endfor
	-rmdir ${.CURDIR}/public/

#
# HTML targets
# Use DOC_LANG to choose the language, e.g., make DOC_LANG="en fr" html-books
#
html: html-articles html-books

html-books-target:
.for _lang in ${BOOK_LANGS}
TMPH += ${.CURDIR}/content/${_lang}/books/*/
.endfor
BOOKSDIR != echo ${TMPH}

html-articles-target:
.for _lang in ${ARTICLE_LANGS}
TTMPH += ${.CURDIR}/content/${_lang}/articles/*/
.endfor
ARTICLESDIR != echo ${TTMPH}

html-books: html-books-target generate-books-toc

# Books build
#
.for _curhtml in ${BOOKSDIR}
	@mkdir -p ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}
.if exists(${_curhtml}book.adoc)
	${ASCIIDOCTOR_CMD} \
	-B ${.CURDIR}/ \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/git-macro.rb \
	-r ./shared/lib/packages-macro.rb \
	-r ./shared/lib/inter-document-references-macro.rb \
	-r ./shared/lib/sectnumoffset-treeprocessor.rb \
	--doctype=book \
	-a skip-front-matter \
	-a linkcss -a copycss=${.CURDIR}/themes/beastie/static/css/docbook.css -a stylesheet=docbook.css -a stylesdir=../../css \
	-a iconfont-remote! -a iconfont-name=font-awesome-min \
	-o ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}book.html \
	${_curhtml}book.adoc
.if exists(${.CURDIR}/static/images/books/${_curhtml:H:T})
	@mkdir -p ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/images/books/
	cp -R ${.CURDIR}/static/images/books/${_curhtml:H:T}/ \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/images/books/${_curhtml:H:T}/
	${SED_CMD} -i '' -e "s|../../../../images|../../images|g" \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}book.html
.endif
.else
# some books use _index.adoc as main document
	${ASCIIDOCTOR_CMD} \
	-B ${.CURDIR}/ \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/git-macro.rb \
	-r ./shared/lib/packages-macro.rb \
	-r ./shared/lib/inter-document-references-macro.rb \
	-r ./shared/lib/sectnumoffset-treeprocessor.rb \
	--doctype=book \
	-a skip-front-matter \
	-a linkcss -a copycss=${.CURDIR}/themes/beastie/static/css/docbook.css -a stylesheet=docbook.css -a stylesdir=../../css \
	-a iconfont-remote! -a iconfont-name=font-awesome-min \
	-o ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}book.html \
	${_curhtml}_index.adoc
.if exists(${.CURDIR}/static/images/books/${_curhtml:H:T})
	@mkdir -p ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/images/books/
	cp -R ${.CURDIR}/static/images/books/${_curhtml:H:T}/ \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/images/books/${_curhtml:H:T}/
	${SED_CMD} -i '' -e "s|../../../../images|../../images|g" \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}book.html
.endif
.endif
.if !exists(${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/fonts/)
	mkdir -p ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/fonts/
	cp -R ${.CURDIR}/themes/beastie/static/fonts/ \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/fonts/
	cp ${.CURDIR}/themes/beastie/static/css/font-awesome-min.css \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/css/
.endif
.endfor

html-articles: html-articles-target

# Articles build
.for _curhtml in ${ARTICLESDIR}
	@mkdir -p ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}
	${ASCIIDOCTOR_CMD} \
	-B ${.CURDIR}/ \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/man-macro.rb \
	-r ./shared/lib/git-macro.rb \
	-r ./shared/lib/packages-macro.rb \
	-r ./shared/lib/inter-document-references-macro.rb \
	-r ./shared/lib/sectnumoffset-treeprocessor.rb \
	--doctype=article \
	-a skip-front-matter \
	-a linkcss -a copycss=${.CURDIR}/themes/beastie/static/css/docbook.css -a stylesheet=docbook.css -a stylesdir=../../css \
	-a iconfont-remote! -a iconfont-name=font-awesome-min \
	-o ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}article.html \
	${_curhtml}_index.adoc
.if exists(${.CURDIR}/static/source/articles/${_curhtml:H:T})
	cp -R ${.CURDIR}/static/source/articles/${_curhtml:H:T}/ \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}
.endif
.if exists(${.CURDIR}/static/images/articles/${_curhtml:H:T})
	@mkdir -p ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/images/articles/
	cp -R ${.CURDIR}/static/images/articles/${_curhtml:H:T}/ \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/images/articles/${_curhtml:H:T}/
	${SED_CMD} -i '' -e "s|../../../images|../../images|g" \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}article.html
.endif
.if !exists(${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/fonts/)
	mkdir -p ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/fonts/
	cp -R ${.CURDIR}/themes/beastie/static/fonts/ \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/fonts/
	cp ${.CURDIR}/themes/beastie/static/css/font-awesome-min.css \
		${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||:H:H:H}/css/
.endif
.endfor

html-clean: html-resources-clean html-articles-clean html-books-clean

html-resources-clean:
.for _lang in ${LANGUAGES}
	rm -fr  ${.CURDIR}/public/${_lang}/css
	rm -fr  ${.CURDIR}/public/${_lang}/fonts
	rm -fr  ${.CURDIR}/public/${_lang}/images
.endfor

html-books-clean: html-books-target toc-clean
.for _curhtml in ${BOOKSDIR}
	rm -f ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}book.html ${_curhtml}toc*.adoc
	-rmdir ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}
.endfor
.for _lang in ${BOOK_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/books
	rm -fr ${.CURDIR}/public/${_lang}/images/books
	-rmdir ${.CURDIR}/public/${_lang}
.endfor
	-rmdir ${.CURDIR}/public

html-articles-clean: html-articles-target
.for _curhtml in ${ARTICLESDIR}
	rm -f ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}article.html
	-rmdir ${.CURDIR}/public${_curhtml:S|^${.CURDIR}/content||}
.endfor
.for _lang in ${ARTICLE_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/articles
	rm -fr ${.CURDIR}/public/${_lang}/images/articles
	-rmdir ${.CURDIR}/public/${_lang}
.endfor
	-rmdir ${.CURDIR}/public

pdf-articles-clean: pdf-articles-target
.for _curpdf in ${ARTICLESDIR}
	rm -f ${.CURDIR}/public${_curpdf:S|^${.CURDIR}/content||}article.pdf
.endfor
.for _lang in ${ARTICLE_LANGS}
	rm -fr ${.CURDIR}/public/${_lang}/articles
.if !exists(${.CURDIR}/public/${_lang}/books)
	rm -fr ${.CURDIR}/public/${_lang}
.endif
.endfor
	-rmdir ${.CURDIR}/public

