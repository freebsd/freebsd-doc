#
# $FreeBSD: doc/share/mk/doc.docbook.mk,v 1.12 2000/07/14 08:42:49 nbm Exp $
#
# This include file <doc.docbook.mk> handles building and installing of
# DocBook documentation in the FreeBSD Documentation Project.
#
# Documentation using DOCFORMAT=docbook is expected to be marked up
# according to the DocBook DTD
#

# ------------------------------------------------------------------------
#
# Document-specific variables
#
#	DOC		This should be set to the name of the DocBook
#			marked-up file, without the .sgml or .docb suffix.
#			
#			It also determins the name of the output files -
#			${DOC}.html.
#
#	DOCBOOKSUFFIX	The suffix of your document, defaulting to .sgml
#
#	SRCS		The names of all the files that are needed to
#			build this document - This is useful if any of
#			them need to be generated.  Changing any file in
#			SRCS causes the documents to be rebuilt.
#

# ------------------------------------------------------------------------
#
# Variables used by both users and documents:
#
#	JADEFLAGS	Additional options to pass to Jade.  Typically
#			used to define "IGNORE" entities to "INCLUDE"
#			 with "-i<entity-name>"
#
#	TIDYFLAGS	Additional flags to pass to Tidy.  Typically
#			used to set "-raw" flag to handle 8bit characters.
#
#	EXTRA_CATALOGS	Additional catalog files that should be used by
#			any SGML processing applications.
#
#	NO_TIDY		If you do not want to use tidy, set this to "YES".
#
# Documents should use the += format to access these.
#

MASTERDOC?=	${.CURDIR}/${DOC}.sgml

JADE=		${PREFIX}/bin/jade

DSLHTML?=	${DOC_PREFIX}/${LANG_CODE}/share/sgml/freebsd.dsl
DSLPRINT?=	${DOC_PREFIX}/${LANG_CODE}/share/sgml/freebsd.dsl
FREEBSDCATALOG=	${DOC_PREFIX}/share/sgml/catalog

DOCBOOKCATALOG=	${PREFIX}/share/sgml/docbook/catalog
JADECATALOG=	${PREFIX}/share/sgml/jade/catalog
DSSSLCATALOG=	${PREFIX}/share/sgml/docbook/dsssl/modular/catalog

LIB_IMAGES?=

JADEOPTS=	${JADEFLAGS} -c ${FREEBSDCATALOG} -c ${DSSSLCATALOG} -c ${DOCBOOKCATALOG} -c ${JADECATALOG} ${EXTRA_CATALOGS:S/^/-c /g}

KNOWN_FORMATS=	html html.tar html-split html-split.tar txt rtf ps pdf tex dvi tar pdb

# ------------------------------------------------------------------------
#
# Look at ${FORMATS} and work out which documents need to be generated.
# It is assumed that the HTML transformation will always create a file
# called index.html, and that for every other transformation the name
# of the generated file is ${DOC}.format.
#
# ${_docs} will be set to a list of all documents that must be made
# up to date.
#
# ${CLEANFILES} is a list of files that should be removed by the "clean"
# target. ${COMPRESS_EXT:S/^/${DOC}.${_cf}.&/ takes the COMPRESS_EXT
# var, and prepends the filename to each listed extension, building a
# second list of files with the compressed extensions added.
#

# Note: ".for _curformat in ${KNOWN_FORMATS}" is used several times in
# this file. I know they could have been rolled together in to one, much
# larger, loop. However, that would have made things more complicated
# for a newcomer to this file to unravel and understand, and a syntax
# error in the loop would have affected the entire
# build/compress/install process, instead of just one of them, making it
# more difficult to debug.
#

# Note: It is the aim of this file that *all* the targets be available,
# not just those appropriate to the current ${FORMATS} and
# ${INSTALL_COMPRESSED} values.
#
# For example, if FORMATS=html and INSTALL_COMPRESSED=gz you could still
# type
#
#     make book.rtf.bz2
#
# and it will do the right thing. Or
#
#     make install-rtf.bz2
#
# for that matter. But don't expect "make clean" to work if the FORMATS
# and INSTALL_COMPRESSED variables are wrong.
#

.for _curformat in ${FORMATS}
_cf=${_curformat}
.if ${_cf} == "html-split"
_docs+= index.html HTML.manifest
CLEANFILES+= `[ -f HTML.manifest ] && xargs < HTML.manifest` HTML.manifest
.elif ${_cf} == "html-split.tar"
_docs+= ${DOC}.html-split.tar
CLEANFILES+= `[ -f HTML.manifest ] && xargs < HTML.manifest` HTML.manifest
CLEANFILES+= ${DOC}.html-split.tar
.elif ${_cf} == "html"
_docs+= ${DOC}.html
CLEANFILES+= ${DOC}.html
.elif ${_cf} == "html.tar"
_docs+= ${DOC}.html.tar
CLEANFILES+= ${DOC}.html ${DOC}.html.tar
.elif ${_cf} == "txt"
_docs+= ${DOC}.txt
CLEANFILES+= ${DOC}.html ${DOC}.txt
.elif ${_cf} == "dvi"
_docs+= ${DOC}.dvi
CLEANFILES+= ${DOC}.aux ${DOC}.dvi ${DOC}.log ${DOC}.tex
.elif ${_cf} == "ps"
_docs+= ${DOC}.ps
CLEANFILES+= ${DOC}.aux ${DOC}.dvi ${DOC}.log ${DOC}.tex ${DOC}.ps
.elif ${_cf} == "pdf"
_docs+= ${DOC}.pdf
CLEANFILES+= ${DOC}.aux ${DOC}.dvi ${DOC}.log ${DOC}.tex ${DOC}.pdf
.elif ${_cf} == "rtf"
_docs+= ${DOC}.rtf
CLEANFILES+= ${DOC}.rtf
.elif ${_cf} == "tar"
_docs+= ${DOC}.tar
CLEANFILES+= ${DOC}.tar
.elif ${_cf} == "doc"
_docs+= ${DOC}.doc
CLEANFILES+= ${DOC}.doc
.elif ${_cf} == "pdb"
_docs+= ${DOC}.pdb ${.CURDIR:T}.pdb
+CLEANFILES+= ${DOC}.pdb ${.CURDIR:T}.pdb
.endif
.endfor

#
# Build a list of install-${format}.${compress_format} targets to be
# by "make install". Also, add ${DOC}.${format}.${compress_format} to
# ${_docs} and ${CLEANFILES} so they get built/cleaned by "all" and
# "clean".
#

.if defined(INSTALL_COMPRESSED) && !empty(INSTALL_COMPRESSED)
.for _curformat in ${FORMATS}
_cf=${_curformat}
.for _curcomp in ${INSTALL_COMPRESSED}
.if ${_cf} != "html-split"
_curinst+= install-${_curformat}.${_curcomp}
_docs+= ${DOC}.${_curformat}.${_curcomp}
CLEANFILES+= ${DOC}.${_curformat}.${_curcomp}
.endif
.endfor
.endfor
.endif

.MAIN: all

all: ${_docs}

index.html HTML.manifest: ${SRCS} ${LIB_IMAGES}
	${JADE} -V html-manifest -ioutput.html ${JADEOPTS} -d ${DSLHTML} -t sgml ${MASTERDOC}
.if !defined(NO_TIDY)
	-tidy -i -m -f /dev/null ${TIDYFLAGS} `xargs < HTML.manifest`
.endif

${DOC}.html: ${SRCS} ${LIB_IMAGES}
	${JADE} -ioutput.html -V nochunks ${JADEOPTS} -d ${DSLHTML} -t sgml ${MASTERDOC} > ${.TARGET}
.if !defined(NO_TIDY)
	-tidy -i -m -f /dev/null ${TIDYFLAGS} ${.TARGET}
.endif

${DOC}.html-split.tar: HTML.manifest
	tar cf ${.TARGET} `xargs < HTML.manifest`
	tar uf ${.TARGET} ${LIB_IMAGES}

${DOC}.html.tar: ${DOC}.html
	tar cf ${.TARGET} ${DOC}.html
	tar uf ${.TARGET} ${LIB_IMAGES}

${DOC}.txt: ${DOC}.html
	w3m -S -dump ${.ALLSRC} > ${.TARGET}

${DOC}.pdb: ${DOC}.html
	iSiloBSD -y -d0 -Idef ${DOC}.html ${DOC}.pdb

${.CURDIR:T}.pdb: ${DOC}.pdb
	ln -f ${DOC}.pdb ${.CURDIR}.pdb

${DOC}.rtf: ${SRCS}
	${JADE} -Vrtf-backend -ioutput.print ${JADEOPTS} -d ${DSLPRINT} -t rtf -o ${.TARGET} ${MASTERDOC}

${DOC}.tex: ${SRCS}
	${JADE} -Vtex-backend -ioutput.print ${JADEOPTS} -d ${DSLPRINT} -t tex -o ${.TARGET} ${MASTERDOC}

${DOC}.dvi: ${DOC}.tex
	@echo "==> TeX pass 1/3"
	-tex "&jadetex" ${.ALLSRC}
	@echo "==> TeX pass 2/3"
	-tex "&jadetex" ${.ALLSRC}
	@echo "==> TeX pass 3/3"
	-tex "&jadetex" ${.ALLSRC}

${DOC}.pdf: ${DOC}.tex
	@echo "==> PDFTeX pass 1/3"
	-pdftex "&pdfjadetex" ${.ALLSRC}
	@echo "==> PDFTeX pass 2/3"
	-pdftex "&pdfjadetex" ${.ALLSRC}
	@echo "==> PDFTeX pass 3/3"
	pdftex "&pdfjadetex" ${.ALLSRC}

${DOC}.ps: ${DOC}.dvi
	dvips -o ${.TARGET} ${.ALLSRC}

${DOC}.tar: ${SRCS}
	tar cf ${.TARGET} ${.ALLSRC}

# ------------------------------------------------------------------------
#
# Validation targets
#

#
# Lets you quickly check that the document conforms to the DTD without
# having to convert it to any other formats
#

lint validate:
	nsgmls -s -c ${FREEBSDCATALOG} -c ${DOCBOOKCATALOG} ${EXTRA_CATALOGS:S/^/-c /g} ${MASTERDOC}

# ------------------------------------------------------------------------
#
# Compress targets
#

#
# The list of compression extensions this Makefile knows about. If you
# add new compression schemes, add to this list (which is a list of
# extensions, hence bz2, *not* bzip2) and extend the _PROG_COMPRESS_*
# targets.
#

KNOWN_COMPRESS=	gz bz2 zip

#
# You can't build suffix rules to do compression, since you can't
# wildcard the source suffix. So these are defined .USE, to be tacked on
# as dependencies of the compress-* targets.
#

_PROG_COMPRESS_gz: .USE
	gzip -9 -c ${.ALLSRC} > ${.TARGET}

_PROG_COMPRESS_bz2: .USE
	bzip2 -9 -c ${.ALLSRC} > ${.TARGET}

_PROG_COMPRESS_zip: .USE
	zip -j -9 ${.TARGET} ${.ALLSRC}

#
# Build a list of targets for each compression scheme and output format.
# Don't compress the html-split output format.
#
.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
.for _curcompress in ${KNOWN_COMPRESS}
.if ${_cf} == "html-split" || ${_cf} == "html"
${DOC}.${_cf}.tar.${_curcompress}: ${DOC}.${_cf}.tar _PROG_COMPRESS_${_curcompress}
.else
${DOC}.${_cf}.${_curcompress}: ${DOC}.${_cf} _PROG_COMPRESS_${_curcompress}
.endif
.endfor
.endfor

# ------------------------------------------------------------------------
#
# Install targets
#
# Build install-* targets, one per allowed value in FORMATS. Need to
# build two specific targets;
#
#    install-html-split - Handles multiple .html files being generated
#                         from one source. Uses the HTML.manifest file
#                         created by the stylesheets, which should list
#                         each .html file that's been created.
#
#    install-*          - Every other format. The wildcard expands to
#                         the other allowed formats, all of which should
#                         generate just one file.
#
# "beforeinstall" and "afterinstall" are hooks in to this process.
# Redefine them to do things before and after the files are installed,
# respectively.

#
# Build a list of install-format targets to be installed. These will be
# dependencies for the "realinstall" target.
#

.if !defined(INSTALL_ONLY_COMPRESSED) || empty(INSTALL_ONLY_COMPRESSED)
_curinst+= ${FORMATS:S/^/install-/g}
.endif

realinstall: ${_curinst}

.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
.if !target(install-${_cf})
.if ${_cf} == "html-split"
install-${_cf}: index.html
	@[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	${INSTALL_DOCS} `xargs < HTML.manifest` ${DESTDIR}
	@if [ -f ${.OBJDIR}/${DOC}.ln ]; then \
		(cd ${DESTDIR}; sh ${.OBJDIR}/${DOC}.ln); \
	fi
.for _curimage in ${LIB_IMAGES}
	${INSTALL_DOCS} ${_curimage} ${DESTDIR}/${_curimage:H}
.endfor
.for _compressext in ${KNOWN_COMPRESS}
install-${_cf}.tar.${_compressext}: ${DOC}.${_cf}.tar.${_compressext}
	@[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}
.endfor
.elif ${_cf} == "html"
install-${_cf}: ${DOC}.${_cf}
	@[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}
.for _curimage in ${LIB_IMAGES}
	${INSTALL_DOCS} ${_curimage} ${DESTDIR}/${_curimage:H}
.endfor
.else
install-${_cf}: ${DOC}.${_cf}
	@[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}

.for _compressext in ${KNOWN_COMPRESS}
install-${_cf}.${_compressext}: ${DOC}.${_cf}.${_compressext}
	@[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}
.endfor
.endif
.endif
.endfor

# ------------------------------------------------------------------------
#
# Package building
#

#
# realpackage is what is called in each subdirectory when a package
# target is called, or, rather, package calls realpackage in each
# subdirectory as it goes.
#
# packagelist returns the list of targets that would be called during
# package building.
#

realpackage: ${FORMATS:S/^/package-/}
packagelist:
	@echo ${FORMATS:S/^/package-/}

#
# Build a list of package targets for each output target.  Each package
# target depends on the corresponding install target running.
#

.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
package-${_curformat}: install-${_curformat}
.if ${_cf} == "html-split"
	@cp HTML.manifest PLIST
.else
	@echo ${DOC}.${_curformat} > PLIST
	@for lib_images in ${LIB_IMAGES}; do \
		echo $$lib_images >> PLIST; \
	done
.endif
	@pkg_create -v -c -"FDP ${.CURDIR:T} ${_curformat} package" \
		-d -"FDP ${.CURDIR:T} ${_curformat} package" -f PLIST \
		-p ${DESTDIR} ${PACKAGES}/${.CURDIR:T}.${LANGCODE}.${_curformat}.tgz
.endfor
