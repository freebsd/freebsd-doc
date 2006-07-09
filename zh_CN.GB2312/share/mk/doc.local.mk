# $FreeBSD$
# Original Revision: 1.1

SP_ENCODING?=	${LANGCODE:C,^.*\.,,}

PRINTFLAGS+=	-ioutput.for.print

CJKTEXSTY?=	${PREFIX}/bin/cjktexsty
CJKTEXSTY_TEX_FLAGS?= -e ${SP_ENCODING} -f t1song
CJKTEXSTY_PDFTEX_FLAGS?= -c -e ${SP_ENCODING} -f song

# Don't use "?=" in the following two lines.
# They have been pre-defined in "doc.project.mk" and should be overridden here.
HTML2TXT=	${PREFIX}/bin/html2text
HTML2TXTOPTS=	-nobs -style pretty

# In "doc/share/mk/doc.project.mk", "doc.images.mk" and "doc.common.mk"
# are included before "doc.local.mk". Thus, we can use variables defined
# in these two files safely in XXX target:source declaration XXX.
# E.g. ${IMAGES_PDF}, ${LOCAL_IMAGES_EPS}
# ***********************************************************************
#  However, other files "doc.*.mk" are included after "doc.local.mk".
#  We CANNOT use their variables in XXX target:source declaration XXX !!!
# ***********************************************************************
# But no problems about using their variables in other places.
# Then, PMake expands variables just when they are ACTUALLY USED.

PDFJADETEX_PREPROCESS=	${CJKTEXSTY} ${CJKTEXSTY_PDFTEX_FLAGS}
JADETEX_PREPROCESS=	${CJKTEXSTY} ${CJKTEXSTY_TEX_FLAGS}

# For Chinese-specific switch "output.for.print".
print.index: ${SRCS} ${LOCAL_IMAGES_TXT}
	${INIT_INDEX_SGML_CMD}
	${JADE_CMD} -V html-index -V nochunks ${HTMLOPTS} -ioutput.html.images \
		-ioutput.for.print ${JADEOPTS} -t sgml ${MASTERDOC} > /dev/null
