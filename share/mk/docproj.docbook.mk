#
# $Id: docproj.docbook.mk,v 1.10 1999-08-26 19:37:13 nik Exp $
#
# This include file <docproj.docbook.mk> handles installing documentation
# from the FreeBSD Documentation Project.
#
# Your documentation is expected to be marked up according to the DocBook
# DTD. 
#

#
# The Makefile that includes this *must* set the following variables
#
#  MAINTAINER		The e-mail address of the person with overall
#			responsibilty for the documentation
#
#  FORMATS		The output formats that should be generated.
#			Valid values are in ${KNOWN_FORMATS}
#
#  SRCS			One or more files that comprise your documentation.
#
#  DOC                  Controls several things
#  
#                       1. ${DOC}.sgml is assumed to be the name of the
#                          master source file (which will use entities
#                          to include any other .sgml files.
#
#                       2. ${DOC}.<foo> will be the name of the output
#                          files (${DOC}.html, ${DOC}.tex, ${DOC}.ps, and
#                          so on.  Ignored for the "html-split" format,
#                          where the output file(s) start with index.html.
#

#
# Optional variable definitions
#
#  DESTDIR              Directory in which files will be installed.  Note 
#                       that this works on a per-document basis.  If you
#                       try and install two docs with the same DESTDIR they
#                       will most likely overwrite one another.  If you 
#                       want to install more than one document in to a new
#                       directory tree you probably want to set the DOCDIR
#                       variable.
#
#  JADEFLAGS		Additional options to pass to Jade.  Typically
#			used to define "IGNORE" entities to "INCLUDE"
#			with "-i<entity-name>"
#
#  TIDYFLAGS		Additional flags to pass to tidy.  Typically
#			used to set "-raw" flag to handle 8bit characters.
#
#  INSTALL_COMPRESSED	List of compressed versions that will also be
#			built (and installed).  See ${KNOWN_COMPRESS}
#			for list of valid values.
#
#  INSTALL_ONLY_COMPRESSED
#			If non-empty then the "install" target will only
#			install the compressed versions of the output.
#
#  DOC_PREFIX		Path to the root of doc/ tree.  Support files
#			(such as share/sgml/catalog) are expected to
#			be under this path.  Defaults to /usr/doc.
#
#  DOCDIR		The root prefix under which all docs are expected
#                       to install themselves.  Defaults to
#                       /usr/share/doc
#
#  EXTRA_CATALOGS	Additional catalog files that should be used by
#			any SGML processing applications.
#

# ------------------------------------------------------------------------
#
# You shouldn't need to change definitions below here

.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif

JADE=		/usr/local/bin/jade
DSLHTML=	${DOC_PREFIX}/share/sgml/freebsd.dsl
DSLPRINT=	${DOC_PREFIX}/share/sgml/freebsd.dsl

FREEBSDCATALOG= ${DOC_PREFIX}/share/sgml/catalog
DOCBOOKCATALOG= /usr/local/share/sgml/docbook/catalog
JADECATALOG=	/usr/local/share/sgml/jade/catalog
DSSSLCATALOG=   /usr/local/share/sgml/docbook/dsssl/modular/catalog

JADEOPTS=	${JADEFLAGS} -c ${FREEBSDCATALOG} -c ${DSSSLCATALOG} -c ${DOCBOOKCATALOG} -c ${JADECATALOG} ${EXTRA_CATALOGS:S/^/-c /g}

KNOWN_FORMATS= html html-split html-split.tar txt rtf ps pdf tex dvi tar

# ------------------------------------------------------------------------
# If DOC_PREFIX is not set then try and generate a sensible value for it.
#
# If they have used an unedited /usr/share/examples/cvsup/doc-supfile to
# download these files then /usr/doc probably exists.  If it does, then
# use that.  If it doesn't exist then tell the user they must specify
# DOC_PREFIX by hand.
#
.BEGIN:
.if !defined(DOC_PREFIX) || empty(DOC_PREFIX)
.if exists(/usr/doc/share/mk/docproj.docbook.mk)
DOC_PREFIX=/usr/doc
.else
	@echo "You must define the DOC_PREFIX variable.  This should contain"
	@echo "the path to the top of your checked out doc/ repository.  For"
	@echo "example, \"make DOC_PREFIX=/usr/doc\", if that is where the"
	@echo "documentation has been checked out to."
	@exit 1
.endif
.endif

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

.if defined(DOC) && !empty(DOC)
.for _curformat in ${FORMATS}
_cf=${_curformat}
.if ${_cf} == "html-split"
_docs+= index.html HTML.manifest
CLEANFILES+= `xargs < HTML.manifest` HTML.manifest
.elif ${_cf} == "html-split.tar"
_docs+= ${DOC}.html-split.tar
CLEANFILES+= `xargs < HTML.manifest` HTML.manifest
CLEANFILES+= ${DOC}.html-split.tar
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
.elif ${_cf} == "doc"
_docs+= ${DOC}.doc
CLEANFILES+= ${DOC}.doc
.endif
.endfor
.endif

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
	${JADE} -V html-manifest -ioutput.html ${JADEOPTS} -d ${DSLHTML} -t sgml ${DOC}.sgml
	-tidy -i -m -f /dev/null ${TIDYFLAGS} *.html

${DOC}.html: ${SRCS}
	${JADE} -ioutput.html -V nochunks ${JADEOPTS} -d ${DSLHTML} -t sgml ${DOC}.sgml > ${DOC}.html
	-tidy -i -m -f /dev/null ${TIDYFLAGS} ${DOC}.html

${DOC}.html-split.tar: HTML.manifest
	tar cf ${.TARGET} `xargs < HTML.manifest`

${DOC}.txt: ${DOC}.html
	lynx -nolist -dump ${DOC}.html > ${DOC}.txt

${DOC}.rtf: ${SRCS}
	${JADE} -Vrtf-backend -ioutput.print ${JADEOPTS} -d ${DSLPRINT} -t rtf ${DOC}.sgml

${DOC}.doc: ${SRCS}
	${JADE} -ioutput.print ${JADEOPTS} -d ${DSLPRINT} -t doc ${DOC}.sgml

${DOC}.tex: ${SRCS}
	${JADE} -Vtex-backend -ioutput.print ${JADEOPTS} -d ${DSLPRINT} -t tex ${DOC}.sgml

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
# Validation targets
#

#
# Lets you quickly check that the document conforms to the DTD without 
# having to convert it to any other formats
#

validate:
	nsgmls -s -c ${FREEBSDCATALOG} -c ${DOCBOOKCATALOG} ${EXTRA_CATALOGS:S/^/-c /g} ${DOC}.sgml

# ------------------------------------------------------------------------
#
# Package building
#

#
# Build a list of package targets for each output format.  Each package
# target depends on the corresponding install target running.
#
.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
package-${_curformat}: install-${_curformat}
	rm PLIST
.if ${_cf} == "html-split"
	cp HTML.manifest PLIST
.else
	echo ${DOC}.${_curformat} > PLIST
.endif
	pkg_create -v -c COMMENT -d DESCR -f PLIST -p ${DESTDIR} \
		${DOC}.${_curformat}.tgz
.endfor

#
# Build one or more pkg_add(1)'able packages, based on all the current
# values of ${FORMATS}.  Do this by listing all the appropriate
# package-* targets as dependencies.
#

package: ${FORMATS:S/^/package-/}

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
.if defined(DOC) && !empty(DOC)
.if !defined(INSTALL_ONLY_COMPRESSED) || empty(INSTALL_ONLY_COMPRESSED)
_curinst+= ${FORMATS:S/^/install-/g}
.endif
.endif

realinstall: ${_curinst}

.if defined(DOC) && !empty(DOC)
.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
.if !target(install-${_cf})
.if ${_cf} == "html-split"
install-${_cf}: index.html
	[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	@if [ ! -f HTML.manifest ]; then				\
		echo "HTML.manifest file does not exist, can't install";\
		exit 1;							\
	fi
	cp -f `xargs < HTML.manifest` ${DESTDIR}
	-for file in `xargs < HTML.manifest`; do			\
		chmod ${DOCMODE} ${DESTDIR}/$$file;			\
		chown ${DOCOWN}:${DOCGROUP} ${DESTDIR}/$$file;		\
	done
	if [ -f ${.OBJDIR}/${DOC}.ln ]; then 				\
		(cd ${DESTDIR}; sh ${.OBJDIR}/${DOC}.ln); 		\
	fi
.for _compressext in ${KNOWN_COMPRESS}
install-${_cf}.tar.${_compressext}: ${DOC}.${_cf}.tar.${_compressext}
	[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	cp -f ${.ALLSRC} ${DESTDIR}
	chmod ${DOCMODE} ${DESTDIR}/${.ALLSRC}
	-chown ${DOCOWN}:${DOCGROUP} ${DESTDIR}/${.ALLSRC}
.endfor
.else
install-${_cf}: ${DOC}.${_cf}
	[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	cp -f ${.ALLSRC} ${DESTDIR}
	chmod ${DOCMODE} ${DESTDIR}/${.ALLSRC}
	-chown ${DOCOWN}:${DOCGROUP} ${DESTDIR}/${.ALLSRC}

.for _compressext in ${KNOWN_COMPRESS}
install-${_cf}.${_compressext}: ${DOC}.${_cf}.${_compressext}
	[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	cp -f ${.ALLSRC} ${DESTDIR}
	chmod ${DOCMODE} ${DESTDIR}/${.ALLSRC}
	-chown ${DOCOWN}:${DOCGROUP} ${DESTDIR}/${.ALLSRC}
.endfor
.endif
.endif
.endfor
.endif

.for __target in beforeinstall afterinstall depend _SUBDIR
.if !target(${__target})
${__target}:
.endif
.endfor

.include <bsd.own.mk>
.include <bsd.dep.mk>
.include <bsd.obj.mk>
