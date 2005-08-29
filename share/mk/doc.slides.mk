#
# $FreeBSD$
#
# This include file <doc.slides.mk> handles building and installing of
# DocBook Slides in the FreeBSD Documentation Project.
#
# Documentation using DOCFORMAT=slides is expected to be marked up
# according to the DocBook slides DTD.
#
# PDF and HTML output formats are currently supported.
#

# ------------------------------------------------------------------------
#
# Document-specific variables
#
#	DOC		This should be set to the name of the SLIDES
#			marked-up file, without the .xml suffix.
#			
#			It also determins the name of the output files
#			for print output :  ${DOC}.pdf 
#
#	DOCBOOKSUFFIX	The suffix of your document, defaulting to .xml
#

DOCBOOKSUFFIX?=	xml
MASTERDOC?=	${.CURDIR}/${DOC}.${DOCBOOKSUFFIX}

KNOWN_FORMATS=	html pdf sxi

CSS_SHEET?=

SLIDES_XSLDIR=	/usr/local/share/xsl/slides/xsl/
SLIDES_XSLHTML= ${SLIDES_XSLDIR}xhtml/default.xsl
SLIDES_XSLPRINT?= ${SLIDES_XSLDIR}fo/plain.xsl

# Default OpenOffice.Org Template
TEMPLATE?= BSDi

# Loop through formats we should build.
.for _curformat in ${FORMATS}
_cf=${_curformat}

# Create a 'bogus' doc for any format we support or not.  This is so
# that we can fake up a target for it later on, and this target can print
# the warning message about the unsupported format. 
_docs+= ${DOC}.${_curformat}
CLEANFILES+= ${DOC}.${_curformat}

.if ${_cf} == "pdf"
CLEANFILES+= ${DOC}.fo ${DOC}.pdf 
.if ! defined (USE_FOP) && ! defined (USE_XEP)
CLEANFILES+= ${DOC}.aux ${DOC}.log ${DOC}.out texput.log
.endif
.endif

.if ${_cf} == "sxi"
CLEANDIRS+= sxi
.endif

.endfor

XSLTPROCFLAGS?=	--nonet --stringparam draft.mode no
XSLTPROCOPTS=	${XSLTPROCFLAGS}

.MAIN: all

all: ${_docs}

${DOC}.html: ${SRCS}
	${XSLTPROC} ${XSLTPROCOPTS} ${SLIDES_XSLHTML} ${.CURDIR}/${DOC}.xml

${DOC}.sxi: ${SRCS}
	${XSLTPROC} ${XSLTPROCOPTS} ${DOC_PREFIX}/share/openoffice/${TEMPLATE}.xsl ${.CURDIR}/slides.xml > ${.OBJDIR}/content.xml
	(cd ${DOC_PREFIX}/share/openoffice/${TEMPLATE}; zip -r ${.OBJDIR}/${DOC}.sxi . -x \*/CVS/\* -x CVS/\*)
	(cd ${.OBJDIR}; zip -g ${DOC}.sxi content.xml)

${DOC}.fo: ${SRCS}
.if defined(USE_SAXON)
	${SAXON_CMD} ${DOC}.xml ${SLIDES_XSLPRINT} > ${.TARGET:S/.pdf$/.fo/}
.else
	${XSLTPROC} ${XSLTPROCOPTS} ${SLIDES_XSLPRINT} ${.CURDIR}/${DOC}.xml > ${.OBJDIR}/${.TARGET:S/.pdf$/.fo/}
.endif

${DOC}.pdf: ${DOC}.fo
.if defined(USE_FOP)
	${FOP_CMD} ${.OBJDIR}/${.TARGET:S/.pdf$/.fo/} ${.OBJDIR}/${.TARGET}
.elif defined(USE_XEP)
	${XEP_CMD} ${.OBJDIR}/${.TARGET:S/.pdf$/.fo/} ${.OBJDIR}/${.TARGET}
.else
	${PDFTEX_CMD} --interaction nonstopmode "&pdfxmltex" ${.OBJDIR}/${.TARGET:S/.pdf$/.fo/}
.endif
