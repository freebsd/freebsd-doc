# 
# $Id: Makefile,v 1.9 1999-01-25 21:58:47 nik Exp $
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
#    txt html html-split ps pdf rtf
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
# compressed versions of built files. As a side effect, setting this option
# means the html-split format *will not* be installed, even if it's listed
# in ${FORMATS}, because it can not be compressed.
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

JADE=		/usr/local/bin/jade
DSLHTML=	../../share/sgml/freebsd.dsl
DSLPRINT=	../../share/sgml/freebsd.dsl

FREEBSDCATALOG= ../../share/sgml/catalog
DOCBOOKCATALOG= /usr/local/share/sgml/docbook/3.0/catalog
JADECATALOG=	/usr/local/share/sgml/jade/catalog
DSSSLCATALOG=   /usr/local/share/sgml/docbook/dsssl/modular/catalog

JADEFLAGS=	${JADEOPTS} -c ${FREEBSDCATALOG} -c ${DSSSLCATALOG} -c ${DOCBOOKCATALOG} -c ${JADECATALOG}

KNOWN_FORMATS= html html-split txt rtf ps pdf tex dvi

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
.endif
.if !empty(INSTALL_COMPRESSED) && ${_cf} != "html-split"
_clean:= ${CLEANFILES} ${INSTALL_COMPRESSED:S/^/${DOC}.${_cf}.&/}
CLEANFILES:= ${_clean}
.endif
.endfor

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
	${JADE} -ioutput.html ${JADEFLAGS} -d ${DSLHTML} -t sgml ${DOC}.sgml
	-tidy -i -m -f /dev/null *.html

${DOC}.html: ${SRCS}
	${JADE} -ioutput.html -V nochunks ${JADEFLAGS} -d ${DSLHTML} -t sgml ${DOC}.sgml > ${DOC}.html
	-tidy -i -m -f /dev/null ${DOC}.html

${DOC}.txt: ${DOC}.html
	lynx -nolist -dump ${DOC}.html > ${DOC}.txt

${DOC}.rtf: ${SRCS}
	${JADE} -ioutput.print ${JADEFLAGS} -d ${DSLPRINT} -t rtf ${DOC}.sgml

${DOC}.tex: ${SRCS}
	${JADE} -ioutput.print ${JADEFLAGS} -d ${DSLPRINT} -t tex ${DOC}.sgml

${DOC}.dvi: ${DOC}.tex
	@echo "==> TeX pass 1/3"
	tex "&jadetex" ${DOC}.tex
	@echo "==> TeX pass 2/3"
	tex "&jadetex" ${DOC}.tex
	@echo "==> Tex pass 3/3"
	tex "&jadetex" ${DOC}.tex

${DOC}.pdf: ${DOC}.tex
	@echo "==> PDFTeX pass 1/3"
	pdftex "&pdfjadetex" ${DOC}.tex
	@echo "==> PDFTeX pass 2/3"
	pdftex "&pdfjadetex" ${DOC}.tex
	@echo "==> PDFTeX pass 3/3"
	pdftex "&pdfjadetex" ${DOC}.tex

${DOC}.ps: ${DOC}.dvi
	dvips -o ${DOC}.ps ${DOC}.dvi

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
.if ${_cf} != "html-split"
.for _curcompress in ${KNOWN_COMPRESS}
${DOC}.${_cf}.${_curcompress}: ${DOC}.${_cf} _PROG_COMPRESS_${_curcompress}
.endfor
.endif
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
# Build a list of install-format-compress_format targets to be installed.
# These will be dependecies for the "realinstall" target.
#
.if !empty(INSTALL_COMPRESSED)
.for _curformat in ${FORMATS}
_cf=${_curformat}
.if ${_cf} != "html-split"
.for _curcomp in ${INSTALL_COMPRESSED}
_curinst+= install-${_curformat}.${_curcomp}
.endfor
.endif
.endfor
.endif

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
		`xargs < HTML.manifest` ${DESTDIR}${DOCDIR}/${VOLUME};
	if [ -f ${.OBJDIR}/${DOC}.ln ]; then 				\
		(cd ${DESTDIR}${DOCDIR}/${VOLUME}; 			\
		sh ${.OBJDIR}/${DOC}.ln); 				\
	fi
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

.include <bsd.dep.mk>
.include <bsd.obj.mk>
