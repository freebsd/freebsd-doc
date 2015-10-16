#
# $FreeBSD$
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
#			marked-up file, without the .xml suffix.
#			
#			It also determins the name of the output files -
#			${DOC}.html.
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
#	EXTRA_CATALOGS	Additional catalog files that should be used by
#			any XML processing applications.
#
#	CSS_SHEET	Full path to a CSS stylesheet suitable for DocBook.
#			Default is ${DOC_PREFIX}/share/misc/docbook.css
#
# Package building options:
# 
#       BZIP2_PACKAGE  Use bzip2(1) utility to compress package tarball
#                      instead of gzip(1).  It results packages to have
#                      suffix .tbz instead of .tgz.  Using bzip2(1)
#                      provides better compression, but requires longer
#                      time and utilizes more CPU resources than gzip(1).

# Either dblatex or fop
RENDERENGINE?=	fop

#
# Documents should use the += format to access these.
#

MASTERDOC?=	${.CURDIR}/${DOC}.xml

DB5RNC?=	${DOC_PREFIX}/share/xml/freebsd50.rnc

XSLPROF?=	http://docbook.sourceforge.net/release/xsl-ns/current/profiling/profile.xsl
XSLXHTML?=	http://www.FreeBSD.org/XML/share/xml/freebsd-xhtml.xsl
XSLXHTMLCHUNK?=	http://www.FreeBSD.org/XML/share/xml/freebsd-xhtml-chunk.xsl
XSLEPUB?=	http://www.FreeBSD.org/XML/share/xml/freebsd-epub.xsl
XSLFO?=		http://www.FreeBSD.org/XML/share/xml/freebsd-fo.xsl

XSLSCH?=	/usr/local/share/xsl/iso-schematron/xslt1/iso_schematron_skeleton_for_xslt1.xsl

IMAGES_LIB?=

SCHEMATRONS?=	${DOC_PREFIX}/share/xml/freebsd.sch
XSLTPROCOPTS?=	--nonet

IMGDIR?=	${IMAGES_EN_DIR}/${DOC}s/${.CURDIR:T}
CALLOUTDIR=	${.CURDIR}/imagelib/callouts
XSLDBLATEX=	${DOC_PREFIX}/share/xml/freebsd-dblatex.xsl
DBLATEXOPTS?=	-I ${IMGDIR} -p ${XSLDBLATEX} -T simple -b xetex -d
FOPJAVAOPTS?=	-Xss1024k -Xmx1431552k
FOPOPTS?=	-c ${DOC_PREFIX}/share/misc/fop.xconf

KNOWN_FORMATS=	html html.tar html-split html-split.tar \
		epub txt rtf ps pdf tex dvi tar pdb

CSS_SHEET?=	${DOC_PREFIX}/share/misc/docbook.css

#
# Instruction for bsd.subdir.mk to not to process SUBDIR directive.
# It is not necessary since doc.docbook.mk do it too.
#
NO_SUBDIR=      YES

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

.if ${.OBJDIR} != ${.CURDIR}
LOCAL_CSS_SHEET= ${.OBJDIR}/${CSS_SHEET:T}
.else
LOCAL_CSS_SHEET= ${CSS_SHEET:T}
.endif

CLEANFILES+= ${DOC}.parsed.xml ${DOC}.parsed.print.xml

.if ${FORMATS:R:Mhtml-split} && ${FORMATS:R:Mhtml}
XSLTPROCOPTS+=	--param docformatnav "'1'"
.endif

.for _curformat in ${FORMATS}
_cf=${_curformat}

.if ${_cf} == "html-split"
_docs+= index.html HTML.manifest ln*.html
CLEANFILES+= $$([ -f HTML.manifest ] && ${XARGS} < HTML.manifest) \
		HTML.manifest ln*.html
CLEANFILES+= PLIST.${_curformat}

.else
_docs+= ${DOC}.${_curformat}
CLEANFILES+= ${DOC}.${_curformat}
CLEANFILES+= PLIST.${_curformat}

.if ${_cf} == "html-split.tar"
CLEANFILES+= $$([ -f HTML.manifest ] && ${XARGS} < HTML.manifest) \
		HTML.manifest ln*.html

.elif ${_cf} == "epub"
CLEANFILES+= ${DOC}.epub mimetype
CLEANDIRS+= META-INF OEBPS

.elif ${_cf} == "html.tar"
CLEANFILES+= ${DOC}.html

.elif ${_cf} == "txt"
CLEANFILES+= ${DOC}.html-text

.elif ${_cf} == "dvi"
CLEANFILES+= ${DOC}.aux ${DOC}.log ${DOC}.out ${DOC}.tex ${DOC}.tex-tmp

.elif ${_cf} == "rtf"
CLEANFILES+= ${DOC}.rtf-nopng

.elif ${_cf} == "tex"
CLEANFILES+= ${DOC}.aux ${DOC}.log

.elif ${_cf} == "ps"
CLEANFILES+= ${DOC}.aux ${DOC}.dvi ${DOC}.log ${DOC}.out ${DOC}.tex-ps \
	${DOC}.tex ${DOC}.tex-tmp ${DOC}.fo
.for _curimage in ${LOCAL_IMAGES_EPS:M*share*}
CLEANFILES+= ${_curimage:T} ${_curimage:H:T}/${_curimage:T}
.endfor

.elif ${_cf} == "pdf"
CLEANFILES+= ${DOC}.aux ${DOC}.dvi ${DOC}.log ${DOC}.out ${DOC}.tex-pdf ${DOC}.tex-pdf-tmp \
		${DOC}.tex ${DOC}.fo
.if ${RENDERENGINE} == "fop"
XSLTPROCOPTS+=	--param img.src.path "'${IMGDIR}/'"
XSLTPROCOPTS+=	--param callout.graphics.path "'${CALLOUTDIR}/'"
XSLTPROCOPTS+=	--maxdepth 6000
.endif
.for _curimage in ${LOCAL_IMAGES_EPS:M*share*}
CLEANFILES+= ${_curimage:T} ${_curimage:H:T}/${_curimage:T}
.endfor

.elif ${_cf} == "pdb"
_docs+= ${.CURDIR:T}.pdb
CLEANFILES+= ${.CURDIR:T}.pdb

.endif
.endif

.if (${LOCAL_CSS_SHEET} != ${CSS_SHEET}) && \
    (${_cf} == "html-split" || ${_cf} == "html-split.tar" || \
     ${_cf} == "html" || ${_cf} == "html.tar" || ${_cf} == "txt")
CLEANFILES+= ${LOCAL_CSS_SHEET}
.endif

.if !defined(WITH_INLINE_LEGALNOTICE) || empty(WITH_INLINE_LEGALNOTICE) && \
    (${_cf} == "html-split" || ${_cf} == "html-split.tar" || \
     ${_cf} == "html" || ${_cf} == "html.tar" || ${_cf} == "txt")
.endif

.endfor		# _curformat in ${FORMATS} #


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

.if ${_cf} != "html-split" && ${_cf} != "html" && ${_cf} != "epub"
_curinst+= install-${_curformat}.${_curcomp}
_docs+= ${DOC}.${_curformat}.${_curcomp}
CLEANFILES+= ${DOC}.${_curformat}.${_curcomp}

.if  ${_cf} == "pdb"
_docs+= ${.CURDIR:T}.${_curformat}.${_curcomp}
CLEANFILES+= ${.CURDIR:T}.${_curformat}.${_curcomp}

.endif
.endif
.endfor
.endfor
.endif

.MAIN: all

all: ${SRCS} ${_docs}

.if defined(SCHEMATRONS)
.for sch in ${SCHEMATRONS}
schxslts+=	${sch:T}.xsl
CLEANFILES+=	${sch:T}.xsl

${sch:T}.xsl: ${sch}
	${XSLTPROC} --param allow-foreign "true" ${XSLSCH} ${.ALLSRC} > ${.TARGET}
.endfor
.endif

# Parsed XML  -------------------------------------------------------

${DOC}.parsed.xml: ${SRCS} ${XML_INCLUDES}
	${XMLLINT} --nonet --noent --valid --dropdtd --xinclude ${MASTERDOC} > ${.TARGET}.tmp
.if defined(PROFILING)
	@${ECHO} "==> Profiling"
	${XSLTPROC} ${PROFILING} ${XSLPROF} ${.TARGET}.tmp > ${.TARGET}
	${RM} ${.TARGET}.tmp
.else
	${MV} ${.TARGET}.tmp ${.TARGET}
.endif
	${SED} 's|@@URL_RELPREFIX@@|http://www.FreeBSD.org|g' < ${.TARGET} > ${DOC}.parsed.print.xml
	${SED} -i '' -e 's|@@URL_RELPREFIX@@|../../../..|g' ${.TARGET}

# translation -------------------------------------------------------

# Master English document
MASTERDOC_EN?=	${MASTERDOC:S/${LANGCODE}/en_US.ISO8859-1/}
TRAN_DIR?=	${MASTERDOC:H}
EN_DIR?=	${TRAN_DIR:S/${LANGCODE}/en_US.ISO8859-1/}
PO_LANG?=	${LANGCODE:C/\..*$//}
PO_CHARSET?=	${LANGCODE:tl:C/^.*\.//:S/^iso/iso-/:S/utf-8/UTF-8/}
EN_XMLLINT?=	${XMLLINT:S/${PO_LANG}/en_US/g}
CLEANFILES+=	${DOC}.translate.xml ${PO_LANG}.mo

# fix settings in PO file
POSET_CMD=	${SED} -i '' -e '1s,^,\#$$FreeBSD$$\${.newline},' \
			     -e 's,^\(\"Language-Team:.*\\n\"\),\1\${.newline}\"Language: ${PO_LANG}\\n\",' \
			     -e 's,^\"Content-Type: text/plain; charset=.*\\n,\"Content-Type: text/plain; charset=${PO_CHARSET}\\n,'

.if ${.TARGETS:Mpo} || ${.TARGETS:Mtran}
${DOC}.translate.xml:
	@if [ "${TRAN_DIR}" == "${EN_DIR}" ]; then \
		${ECHO} "build PO file in a non-English dir" ; \
		exit 1 ; \
	 fi
	# normalize the English original into a single file
	@${EN_XMLLINT} --nonet --noent --valid --xinclude ${MASTERDOC_EN} > ${.TARGET}.tmp
	# remove redundant namespace attributes
	@${EN_XMLLINT} --nsclean ${.TARGET}.tmp > ${.TARGET}
	@${RM} ${.TARGET}.tmp

po: ${PO_LANG}.po
.PHONY:	po
${PO_LANG}.po:	${DOC}.translate.xml
	@${ITSTOOL} -o ${PO_LANG}.po.tmp ${DOC}.translate.xml
	@( if [ -f "${PO_LANG}.po" ]; then \
		echo "${PO_LANG}.po exists, merging" ; \
		${MSGMERGE} -o ${PO_LANG}.po.new ${PO_LANG}.po ${PO_LANG}.po.tmp ;\
		${MV} ${PO_LANG}.po.new ${PO_LANG}.po ; \
		${RM} ${PO_LANG}.po.tmp ; \
	  else \
	  	${ECHO} "${PO_LANG}.po created, please check and correct the settings in the header" ; \
		${MV} ${PO_LANG}.po.tmp ${PO_LANG}.po ; \
		${POSET_CMD} ${.TARGET} ; \
	  fi )

${PO_LANG}.mo:	${PO_LANG}.po
	@${MSGFMT} -o ${.TARGET} ${.ALLSRC}

tran ${DOC}.xml:	${DOC}.translate.xml ${PO_LANG}.mo
	@if [ "${TRAN_DIR}" = "${EN_DIR}" ]; then \
		${ECHO} "build translation in a non-English dir" ; \
		exit 1 ; \
	 fi
	${ITSTOOL} -l ${PO_LANG} -m ${PO_LANG}.mo -o ${DOC}.xml ${DOC}.translate.xml
.endif

# XHTML -------------------------------------------------------------

index.html: ${DOC}.parsed.xml ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG} \
	${HTML_SPLIT_INDEX} ${LOCAL_CSS_SHEET} ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} ${XSLXHTMLCHUNK} ${DOC}.parsed.xml

${DOC}.html: ${DOC}.parsed.xml ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG} \
	${LOCAL_CSS_SHEET} ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} ${XSLXHTML} ${DOC}.parsed.xml > ${.TARGET}

${DOC}.html-split.tar: HTML.manifest ${LOCAL_IMAGES_LIB} \
		       ${LOCAL_IMAGES_PNG} ${LOCAL_CSS_SHEET}
	${TAR} cf ${.TARGET} $$(${XARGS} < HTML.manifest) \
		${LOCAL_IMAGES_LIB} ${IMAGES_PNG:N*share*} ${CSS_SHEET:T}
.for _curimage in ${IMAGES_PNG:M*share*}
	${TAR} rf ${.TARGET} -C ${IMAGES_EN_DIR}/${DOC}s/${.CURDIR:T} ${_curimage:S|${IMAGES_EN_DIR}/${DOC}s/${.CURDIR:T}/||}
.endfor

${DOC}.html.tar: ${DOC}.html ${LOCAL_IMAGES_LIB} \
		 ${LOCAL_IMAGES_PNG} ${LOCAL_CSS_SHEET}
	${TAR} cf ${.TARGET} ${DOC}.html \
		${LOCAL_IMAGES_LIB} ${IMAGES_PNG:N*share*} ${CSS_SHEET:T}
.for _curimage in ${IMAGES_PNG:M*share*}
	${TAR} rf ${.TARGET} -C ${IMAGES_EN_DIR}/${DOC}s/${.CURDIR:T} ${_curimage:S|${IMAGES_EN_DIR}/${DOC}s/${.CURDIR:T}/||}
.endfor

# EPUB -------------------------------------------------------------

${DOC}.epub: ${DOC}.parsed.xml ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG} \
	${CSS_SHEET} ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} ${XSLEPUB} ${DOC}.parsed.xml
.if defined(LOCAL_IMAGES_LIB) || defined(LOCAL_IMAGES_PNG)
.for f in ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG}
	${CP} ${f} OEBPS/
.endfor
.endif
	${ZIP} ${ZIPOPTS} -r -X ${DOC}.epub mimetype OEBPS META-INF

# TXT --------------------------------------------------------------------

.if !target(${DOC}.txt)
.if !defined(NO_PLAINTEXT)
${DOC}.txt: ${DOC}.html
	${HTML2TXT} ${HTML2TXTOPTS} ${.ALLSRC} > ${.TARGET}
.else
${DOC}.txt:
	${TOUCH} ${.TARGET}
.endif	
.endif

# PDB --------------------------------------------------------------------

${DOC}.pdb: ${DOC}.html ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG}
	${HTML2PDB} ${HTML2PDBOPTS} ${DOC}.html ${.TARGET}

${.CURDIR:T}.pdb: ${DOC}.pdb
	${LN} -f ${.ALLSRC} ${.TARGET}

.if defined(INSTALL_COMPRESSED) && !empty(INSTALL_COMPRESSED)
.for _curcomp in ${INSTALL_COMPRESSED}
${.CURDIR:T}.pdb.${_curcomp}: ${DOC}.pdb.${_curcomp}
	${LN} -f ${.ALLSRC} ${.TARGET}
.endfor
.endif

# PS/PDF/RTF -----------------------------------------------------------------

${DOC}.fo: ${DOC}.xml ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG} ${DOC}.parsed.xml ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} ${XSLFO} ${DOC}.parsed.print.xml > ${.TARGET}

.if ${RENDERENGINE} == "fop"
${DOC}.pdf: ${DOC}.fo ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG}
	${SETENV} FOP_OPTS="${FOPJAVAOPTS}" ${FOP} ${FOPOPTS} ${DOC}.fo ${.TARGET}

${DOC}.ps: ${DOC}.fo ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG}
	${SETENV} FOP_OPTS="${FOPJAVAOPTS}" ${FOP} ${FOPOPTS} ${DOC}.fo ${.TARGET}

${DOC}.rtf: ${DOC}.fo ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG}
	${SETENV} FOP_OPTS="${FOPJAVAOPTS}" ${FOP} ${FOPOPTS} ${DOC}.fo ${.TARGET}
.else
# Default is dblatex
${DOC}.pdf: ${DOC}.parsed.xml ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG}
	${DBLATEX} ${DOC}.parsed.print.xml ${DBLATEXOPTS} -o ${.TARGET}

${DOC}.ps: ${DOC}.parsed.xml ${LOCAL_IMAGES_LIB} ${LOCAL_IMAGES_PNG}
	${DBLATEX} ${DOC}.parsed.print.xml ${DBLATEXOPTS} -o ${.TARGET}
.endif
	

${DOC}.tar: ${SRCS} ${LOCAL_IMAGES} ${LOCAL_CSS_SHEET}
	${TAR} cf ${.TARGET} -C ${.CURDIR} ${SRCS} \
		-C ${.OBJDIR} ${IMAGES} ${CSS_SHEET:T}

#
# Build targets for any formats we've missed that we don't handle.
#
.for _curformat in ${ALL_FORMATS}
.if !target(${DOC}.${_curformat})
${DOC}.${_curformat}:
	@${ECHO_CMD} \"${_curformat}\" is not a valid output format for this document.
.endif
.endfor


# ------------------------------------------------------------------------
#
# Validation targets
#

#
# Lets you quickly check that the document conforms to the DTD without
# having to convert it to any other formats
#

#
# XXX: There is duplicated code below. In general, we want to see what
# is actually run but when validation is executed, it is better to
# silence the command invocation so that only error messages appear.
#

lint validate: ${SRCS} ${schxslts}
	@${ECHO} "==> Basic validation"
	@${XMLLINT} --nonet --noent --valid --dropdtd --xinclude ${MASTERDOC} > ${DOC}.parsed.xml
.if defined(schxslts)
	@${ECHO} "==> Validating with Schematron constraints"
.for sch in ${schxslts}
	@( out=`${XSLTPROC} ${sch} ${DOC}.parsed.xml`; \
	  if [ -n "$${out}" ]; then \
		echo "$${out}" | ${GREP} -v '^<?xml'; \
		false; \
	  fi )
.endfor
.endif
.if exists(${JING})
	@${ECHO} "==> Validating with RELAX NG"
	@${JING} -c ${DB5RNC} ${DOC}.parsed.xml
.endif
	@${RM} -rf ${CLEANFILES} ${CLEANDIRS} ${DOC}.parsed.xml

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
	${GZIP} ${GZIPOPTS} < ${.ALLSRC} > ${.TARGET}

_PROG_COMPRESS_bz2: .USE
	${BZIP2} ${BZIP2OPTS} < ${.ALLSRC} > ${.TARGET}

_PROG_COMPRESS_zip: .USE
	${ZIP} ${ZIPOPTS} ${.TARGET} ${.ALLSRC}

#
# Build a list of targets for each compression scheme and output format.
# Don't compress the html-split or html output format (because they need
# to be rolled in to tar files first).
#
.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
.for _curcompress in ${KNOWN_COMPRESS}
.if ${_cf} == "html-split" || ${_cf} == "html"
${DOC}.${_cf}.tar.${_curcompress}: ${DOC}.${_cf}.tar \
				   _PROG_COMPRESS_${_curcompress}
.else
${DOC}.${_cf}.${_curcompress}: ${DOC}.${_cf} _PROG_COMPRESS_${_curcompress}
.endif
.endfor
.endfor

#
# Build targets for any formats we've missed that we don't handle.
#
.for _curformat in ${ALL_FORMATS}
.for _curcompress in ${KNOWN_COMPRESS}
.if !target(${DOC}.${_curformat}.${_curcompress})
${DOC}.${_curformat}.${_curcompress}:
	@${ECHO_CMD} \"${_curformat}.${_curcompress}\" is not a valid output format for this document.
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

populate_html_docs:
.if exists(HTML.manifest)
_html_docs!=${CAT} HTML.manifest
.endif

spellcheck-html-split: populate_html_docs
.for _html_file in ${_html_docs}
	@echo "Spellcheck ${_html_file}"
	@${HTML2TXT} ${HTML2TXTOPTS} ${.CURDIR}/${_html_file} | ${ISPELL} ${ISPELLOPTS}
.endfor
spellcheck-html:
.for _entry in ${_docs}
	@echo "Spellcheck ${_entry}"
	@${HTML2TXT} ${HTML2TXTOPTS} ${.CURDIR}/${_entry} | ${ISPELL} ${ISPELLOPTS}
.endfor
spellcheck-txt:
.for _entry in ${_docs:M*.txt}
	@echo "Spellcheck ${_entry}"
	@ < ${.CURDIR}/${_entry} ${ISPELL} ${ISPELLOPTS}
.endfor
.for _curformat in ${FORMATS}
.if !target(spellcheck-${_curformat})
spellcheck-${_curformat}:
	@echo "Spellcheck is not currently supported for the ${_curformat} format."
.endif
.endfor

spellcheck: ${FORMATS:C/^/spellcheck-/}

#
# Build a list of install-format targets to be installed. These will be
# dependencies for the "realinstall" target.
#

.if !defined(INSTALL_ONLY_COMPRESSED) || empty(INSTALL_ONLY_COMPRESSED)
_curinst+= ${FORMATS:S/^/install-/g}
.endif

.if defined(NO_TEX)
_curinst_filter+=N*dvi* N*tex* N*ps* N*pdf*
.endif
.if defined(NO_RTF)
_curinst_filter+=N*rtf*
.endif
.if defined(NO_PLAINTEXT)
_curinst_filter+=N*txt*
.endif

_cff!=${ECHO_CMD} "${_curinst_filter}" | ${SED} 's, ,:,g'

.if !defined(_cff) || empty(_cff)
realinstall: ${_curinst}
.else
.for i in ${_cff}
realinstall: ${_curinst:$i}
.endfor
.endif

.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
.if !target(install-${_cf})
.if ${_cf} == "html-split"
install-${_curformat}: index.html
.else
install-${_curformat}: ${DOC}.${_curformat}
.endif
	@[ -d ${DESTDIR} ] || ${MKDIR} -p ${DESTDIR}
.if ${_cf} == "html-split"
	${INSTALL_DOCS} $$(${XARGS} < HTML.manifest) ${DESTDIR}
.else
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}
.endif
.if (${_cf} == "html-split" || ${_cf} == "html") && !empty(LOCAL_CSS_SHEET)
	${INSTALL_DOCS} ${LOCAL_CSS_SHEET} ${DESTDIR}
.if ${_cf} == "html-split"
	@if [ -f ln*.html ]; then \
		${INSTALL_DOCS} ln*.html ${DESTDIR}; \
	fi
	@if [ -f LEGALNOTICE.html ]; then \
		${INSTALL_DOCS} LEGALNOTICE.html ${DESTDIR}; \
	fi
	@if [ -f trademarks.html ]; then \
		${INSTALL_DOCS} trademarks.html ${DESTDIR}; \
	fi
	@if [ -f ${.OBJDIR}/${DOC}.ln ]; then \
		cd ${DESTDIR}; sh ${.OBJDIR}/${DOC}.ln; \
	fi
.endif
.for _curimage in ${IMAGES_LIB}
	@[ -d ${DESTDIR}/${LOCAL_IMAGES_LIB_DIR}/${_curimage:H} ] || \
		${MKDIR} -p ${DESTDIR}/${LOCAL_IMAGES_LIB_DIR}/${_curimage:H}
	${INSTALL_DOCS} ${LOCAL_IMAGES_LIB_DIR}/${_curimage} \
			${DESTDIR}/${LOCAL_IMAGES_LIB_DIR}/${_curimage:H}
.endfor
# Install the images.  First, loop over all the image names that contain a
# directory separator, make the subdirectories, and install.  Then loop over
# the ones that don't contain a directory separator, and install them in the
# top level.
# Install at first images from /usr/share/images then localized ones
# cause of a different origin path.
.for _curimage in ${IMAGES_PNG:M*/*:M*share*}
	${MKDIR} -p ${DESTDIR:H:H}/${_curimage:H:S|${IMAGES_EN_DIR}/||:S|${.CURDIR}||}
	${INSTALL_DOCS} ${_curimage} ${DESTDIR:H:H}/${_curimage:H:S|${IMAGES_EN_DIR}/||:S|${.CURDIR}||}
.endfor
.for _curimage in ${IMAGES_PNG:M*/*:N*share*}
	${MKDIR} -p ${DESTDIR}/${_curimage:H}
	${INSTALL_DOCS} ${_curimage} ${DESTDIR}/${_curimage:H}
.endfor
.for _curimage in ${IMAGES_PNG:N*/*}
	${INSTALL_DOCS} ${_curimage} ${DESTDIR}/${_curimage}
.endfor
.elif ${_cf} == "tex" || ${_cf} == "dvi"
.for _curimage in ${IMAGES_EPS:M*/*}
	${MKDIR} -p ${DESTDIR}/${_curimage:H:S|${IMAGES_EN_DIR}/||:S|${.CURDIR:T}/||}
	${INSTALL_DOCS} ${_curimage} ${DESTDIR}/${_curimage:H:S|${IMAGES_EN_DIR}/||:S|${.CURDIR:T}/||}
.endfor
.for _curimage in ${IMAGES_EPS:N*/*}
	${INSTALL_DOCS} ${_curimage} ${DESTDIR}
.endfor
.elif ${_cf} == "pdb"
	${LN} -f ${DESTDIR}/${.ALLSRC} ${DESTDIR}/${.CURDIR:T}.${_curformat}
.endif

.if ${_cf} == "html-split"
.for _compressext in ${KNOWN_COMPRESS}
install-${_curformat}.tar.${_compressext}: ${DOC}.${_curformat}.tar.${_compressext}
	@[ -d ${DESTDIR} ] || ${MKDIR} -p ${DESTDIR}
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}
.endfor
.else
.for _compressext in ${KNOWN_COMPRESS}
.if !target(install-${_curformat}.${_compressext})
install-${_curformat}.${_compressext}: ${DOC}.${_curformat}.${_compressext}
	@[ -d ${DESTDIR} ] || ${MKDIR} -p ${DESTDIR}
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}
.if ${_cf} == "pdb"
	${LN} -f ${DESTDIR}/${.ALLSRC} \
		 ${DESTDIR}/${.CURDIR:T}.${_curformat}.${_compressext}
.endif
.endif
.endfor
.endif
.endif
.endfor

#
# Build install- targets for any formats we've missed that we don't handle.
#

.for _curformat in ${ALL_FORMATS}
.if !target(install-${_curformat})
install-${_curformat}:
	@${ECHO_CMD} \"${_curformat}\" is not a valid output format for this document.

.for _compressext in ${KNOWN_COMPRESS}
install-${_curformat}.${_compressext}:
	@${ECHO_CMD} \"${_curformat}.${_compressext}\" is not a valid output format for this document.
.endfor
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
	@${ECHO_CMD} ${FORMATS:S/^/package-/}

#
# Build a list of package targets for each output target.  Each package
# target depends on the corresponding install target running.
#

.if defined(BZIP2_PACKAGE)
PKG_SUFFIX=	tbz
.else
PKG_SUFFIX=	tgz
.endif

PKGDOCPFX!= realpath ${DOC_PREFIX}

.for _curformat in ${KNOWN_FORMATS}
__curformat=${_curformat}

${PACKAGES}/${.CURDIR:T}.${LANGCODE}.${_curformat}.${PKG_SUFFIX}:
	${MKDIR} -p ${.OBJDIR}/pkg; \
	(cd ${.CURDIR} && \
		${MAKE} FORMATS=${_curformat} \
			DOCDIR=${.OBJDIR}/pkg \
			${PKGMAKEFLAGS} \
			install); \
	PKGSRCDIR=${.OBJDIR}/pkg/${.CURDIR:S/${PKGDOCPFX}\///}; \
	/bin/ls -1 $$PKGSRCDIR > ${.OBJDIR}/PLIST.${_curformat}; \
	${PKG_CREATE} -v -f ${.OBJDIR}/PLIST.${_curformat} \
		-p ${DESTDIR} -s $$PKGSRCDIR \
		-c -"FDP ${.CURDIR:T} ${_curformat} package" \
		-d -"FDP ${.CURDIR:T} ${_curformat} package" ${.TARGET} || \
			(${RM} -fr ${.TARGET} PLIST.${_curformat} && false); \
	${RM} -rf ${.OBJDIR}/pkg

.if !defined(_cff) || empty(_cff)
package-${_curformat}: ${PACKAGES}/${.CURDIR:T}.${LANGCODE}.${_curformat}.${PKG_SUFFIX}
.else
.for i in ${_cff}
.if !empty(__curformat:$i)
package-${_curformat}: ${PACKAGES}/${.CURDIR:T}.${LANGCODE}.${_curformat}.${PKG_SUFFIX}
.else
package-${_curformat}:
.endif
.endfor
.endif

.endfor

.if ${LOCAL_CSS_SHEET} != ${CSS_SHEET}
${LOCAL_CSS_SHEET}: ${CSS_SHEET}
	${RM} -f ${.TARGET}
	${CAT} ${.ALLSRC} > ${.TARGET}
.if defined(CSS_SHEET_ADDITIONS)
	${CAT} ${.CURDIR}/${CSS_SHEET_ADDITIONS} >> ${.TARGET}
.endif
.endif
