# 
# $Id: Makefile,v 1.16 1999-03-22 22:16:23 nik Exp $
#
# Build the FreeBSD Handbook. Will eventually split in two, a generic .mk
# file which can be used by many Makefiles, and a much smaller Makefile
# which uses the generic.mk file.
#
# Note: Doing all this in a Makefile is a little odd. This is because there
# is typically not a 1:1 mapping between the .sgml files and the .html,
# .rtf, .ps, and other formats. For most of them, all the .sgml files will
# become one file in the chosen output format. For HTML, many .html files
# will be produced, but they won't be named after the corresponding .sgml
# files.

MAINTAINER=nik@FreeBSD.ORG

JADEOPTS=

#
# DOC is the root name of file(s) that will be generated (i.e, for
# foo.rtf, foo.ps, etc, DOC=foo. HTML generation ignores this, it 
# is assumed that the stylesheet names this. If not set, DOC defaults
# to the name of the current directory.
#
DOC?= handbook

#
# FORMATS lists the output formats that should be generated. Valid values
# are 
#
#    txt html html-split ps pdf rtf tar
#
# html-split is the file split into (probably) many individual HTML files,
# linked from one index.html file. 
#
# This setting also affects which files will be removed with 'make clean'.
# If you 'make' with one setting, and 'make clean' with another, don't
# be surprised if it doesn't work.
FORMATS?= html-split

#
# INSTALL_COMPRESSED lists the compressed versions to be installed by the
# install-* targets. Valid values are
#
#    gz zip bz2
#
# If left empty then no files will be installed compressed.
#
INSTALL_COMPRESSED?= gz

#
# INSTALL_ONLY_COMPRESSED is non-empty if you only want to install the
# compressed versions of built files. 
#
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  handbook.sgml
SRCS+= advanced-networking/chapter.sgml
SRCS+= backups/chapter.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= contrib/chapter.sgml
SRCS+= cutting-edge/chapter.sgml
SRCS+= disks/chapter.sgml
SRCS+= eresources/chapter.sgml
SRCS+= hw/chapter.sgml
SRCS+= install/chapter.sgml
SRCS+= internals/chapter.sgml
SRCS+= introduction/chapter.sgml
SRCS+= kernelconfig/chapter.sgml
SRCS+= kerneldebug/chapter.sgml
SRCS+= kernelopts/chapter.sgml
SRCS+= l10n/chapter.sgml
SRCS+= linuxemu/chapter.sgml
SRCS+= mail/chapter.sgml
SRCS+= mirrors/chapter.sgml
SRCS+= pgpkeys/chapter.sgml
SRCS+= policies/chapter.sgml
SRCS+= ppp-and-slip/chapter.sgml
SRCS+= printing/chapter.sgml
SRCS+= quotas/chapter.sgml
SRCS+= security/chapter.sgml
SRCS+= serialcomms/chapter.sgml
SRCS+= staff/chapter.sgml
SRCS+= x11/chapter.sgml
SRCS+= ports/chapter.sgml

# Entities
SRCS+= authors.ent 
SRCS+= chapters.ent 
SRCS+= mailing-lists.ent

# ------------------------------------------------------------------------
#
# You shouldn't need to change definitions below here

VOLUME?=	${.CURDIR:T}
DOC?=		${.CURDIR:T}
DISTRIBUTION?=	doc

JADE=		/usr/local/bin/jade
DSLHTML=	../../share/sgml/freebsd.dsl
DSLPRINT=	../../share/sgml/freebsd.dsl

FREEBSDCATALOG= ../../share/sgml/catalog
DOCBOOKCATALOG= /usr/local/share/sgml/docbook/3.0/catalog
JADECATALOG=	/usr/local/share/sgml/jade/catalog
DSSSLCATALOG=   /usr/local/share/sgml/docbook/dsssl/modular/catalog

JADEFLAGS=	${JADEOPTS} -c ${FREEBSDCATALOG} -c ${DSSSLCATALOG} -c ${DOCBOOKCATALOG} -c ${JADECATALOG}

KNOWN_FORMATS= html html-split txt rtf ps pdf tex dvi tar

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
# target. ${COMPRESS_EXT:S/^/${DOC}.${_cf}.&/ takes the COMPRESS_EXT var,
# and prepends the filename to each listed extension, building a second
# list of files with the compressed extensions added.
#

# Note: ".for _curformat in ${KNOWN_FORMATS}" is used several times in this
# file. I know they could have been rolled together in to one, much larger,
# loop. However, that would have made things more complicated for a newcomer
# to this file to unravel and understand, and a syntax error in the loop
# would have affected the entire build/compress/install process, instead
# of just one of them, making it more difficult to debug.

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
CLEANFILES+= `xargs < HTML.manifest` HTML.manifest
.elif ${_cf} == "html"
_docs+= ${DOC}.html
CLEANFILES+= ${DOC}.html
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
.endif
.endfor

#
# Build a list of install-${format}.${compress_format} targets to be
# by "make install". Also, add ${DOC}.${format}.${compress_format} to
# ${_docs} and ${CLEANFILES} so they get built/cleaned by "all" and
# "clean".
#
.if !empty(INSTALL_COMPRESSED)
.for _curformat in ${FORMATS}
_cf=${_curformat}
.for _curcomp in ${INSTALL_COMPRESSED}
.if ${_cf} == "html-split" 
_curinst+= install-html-split.tar.${_curcomp}
_docs+= ${DOC}.html-split.tar.${_curcomp}
.else 
_curinst+= install-${_curformat}.${_curcomp}
_docs+= ${DOC}.${_curformat}.${_curcomp}
CLEANFILES+= ${DOC}.${_curformat}.${_curcomp}
.endif
.endfor
.endfor
.endif

# ------------------------------------------------------------------------
#
# Targets
#

#
# Build Targets
#

# If no target is specifed then .MAIN is made
.MAIN: all

all: ${_docs}

index.html HTML.manifest: ${SRCS}
	${JADE} -V html-manifest -ioutput.html ${JADEFLAGS} -d ${DSLHTML} -t sgml ${DOC}.sgml
	-tidy -i -m -f /dev/null *.html

${DOC}.html: ${SRCS}
	${JADE} -ioutput.html -V nochunks ${JADEFLAGS} -d ${DSLHTML} -t sgml ${DOC}.sgml > ${DOC}.html
	-tidy -i -m -f /dev/null ${DOC}.html

${DOC}.html-split.tar: HTML.manifest
	tar cf ${.TARGET} `xargs < HTML.manifest`

${DOC}.txt: ${DOC}.html
	lynx -nolist -dump ${DOC}.html > ${DOC}.txt

${DOC}.rtf: ${SRCS}
	${JADE} -ioutput.print ${JADEFLAGS} -d ${DSLPRINT} -t rtf ${DOC}.sgml

${DOC}.tex: ${SRCS}
	${JADE} -ioutput.print ${JADEFLAGS} -d ${DSLPRINT} -t tex ${DOC}.sgml

${DOC}.dvi: ${DOC}.tex
	@echo "==> TeX pass 1/3"
	-tex "&jadetex" ${DOC}.tex
	@echo "==> TeX pass 2/3"
	-tex "&jadetex" ${DOC}.tex
	@echo "==> TeX pass 3/3"
	-tex "&jadetex" ${DOC}.tex

${DOC}.pdf: ${DOC}.tex
	@echo "==> PDFTeX pass 1/3"
	-pdftex "&pdfjadetex" ${DOC}.tex
	@echo "==> PDFTeX pass 2/3"
	-pdftex "&pdfjadetex" ${DOC}.tex
	@echo "==> PDFTeX pass 3/3"
	pdftex "&pdfjadetex" ${DOC}.tex

${DOC}.ps: ${DOC}.dvi
	dvips -o ${DOC}.ps ${DOC}.dvi

${DOC}.tar:
	tar cf ${.TARGET} ${SRCS}

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
# You can't build suffix rules to do compression, since you can't wildcard
# the source suffix. So these are defined .USE, to be tacked on as
# dependencies of the compress-* targets.
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
.if ${_cf} == "html-split"
${DOC}.${_cf}.tar.${_curcompress}: ${DOC}.${_cf}.tar _PROG_COMPRESS_${_curcompress}
.else
${DOC}.${_cf}.${_curcompress}: ${DOC}.${_cf} _PROG_COMPRESS_${_curcompress}
.endif
.endfor
.endfor

#
# Install targets
#
# Build install-* targets, one per allowed value in FORMATS. Need to build
# two specific targets;
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
install: beforeinstall realinstall afterinstall

#
# Build a list of install-format targets to be installed. These will be
# dependencies for the "realinstall" target.
#
.if empty(INSTALL_ONLY_COMPRESSED)
_curinst+= ${FORMATS:S/^/install-/g}
.endif

realinstall: ${_curinst}

.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
.if !target(install-${_cf})
.if ${_cf} == "html-split"
install-${_cf}: index.html
	@if [ ! -f HTML.manifest ]; then				\
		echo "HTML.manifest file does not exist, can't install";\
		exit 1;							\
	fi
	${INSTALL} ${COPY} -o ${DOCOWN} -g ${DOCGRP} -m ${DOCMODE} 	\
		`xargs < HTML.manifest` ${DESTDIR}${DOCDIR}/${VOLUME};	\
	if [ -f ${.OBJDIR}/${DOC}.ln ]; then 				\
		(cd ${DESTDIR}${DOCDIR}/${VOLUME}; 			\
		sh ${.OBJDIR}/${DOC}.ln); 				\
	fi
.for _compressext in ${KNOWN_COMPRESS}
install-${_cf}.tar.${_compressext}: ${DOC}.${_cf}.tar.${_compressext}
	${INSTALL} ${COPY} -o ${DOCOWN} -g ${DOCGRP} -m ${DOCMODE}	\
		${.ALLSRC} ${DESTDIR}${DOCDIR}/${VOLUME}
.endfor
.else
install-${_cf}: ${DOC}.${_cf}
	${INSTALL} ${COPY} -o ${DOCOWN} -g ${DOCGRP} -m ${DOCMODE}	\
		${.ALLSRC} ${DESTDIR}${DOCDIR}/${VOLUME}

.for _compressext in ${KNOWN_COMPRESS}
install-${_cf}.${_compressext}: ${DOC}.${_cf}.${_compressext}
	${INSTALL} ${COPY} -o ${DOCOWN} -g ${DOCGRP} -m ${DOCMODE}	\
		${.ALLSRC} ${DESTDIR}${DOCDIR}/${VOLUME}
.endfor
.endif
.endif
.endfor

.for __target in beforeinstall afterinstall depend _SUBDIR
.if !target(${__target})
${__target}:
.endif
.endfor

#
# Distribution target
#
# Like "install", but places the files into the correct distribution
#
#.if !target(distribute)
#distribute:
#.for dist in ${DISTRIBUTION}
#	cd ${.CURDIR}; $(MAKE) install DESTDIR=${DISTDIR}/${dist}
#.endfor
#.endif
.if !target(distribute)
distribute:
	@echo "'distribute' not yet enabled for DocBook Handbook"
.endif

.include <bsd.dep.mk>
.include <bsd.obj.mk>
