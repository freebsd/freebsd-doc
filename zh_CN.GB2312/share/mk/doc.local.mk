# $FreeBSD$
# Original Revision: 1.1

SP_ENCODING?=	${LANGCODE:C,^.*\.,,}

PRINTFLAGS+=	-ioutput.for.print

CJKTEXSTY?=	${PREFIX}/bin/cjktexsty
CJKTEXSTY_TEX_FLAGS?= -e ${SP_ENCODING} -f t1song
CJKTEXSTY_PDFTEX_FLAGS?= -c -e ${SP_ENCODING} -f song

# Don't use "?=" in the following two lines.
# They have been pre-defined in "doc.project.mk".
HTML2TXT=	${PREFIX}/bin/html2text
HTML2TXTOPTS=	-nobs -style pretty

.for _curformat in ${FORMATS}
_cf=${_curformat}
.if ${_cf} == "pdf"
# Temporary auxiliary files generated for teTeX & CJK
CLEANFILES+= ${DOC}.tex-pdf-cjk
.elif ${_cf} == "dvi" || ${_cf} == "ps"
# Temporary auxiliary files generated for teTeX & CJK
# PostScript file comes from corresponding DVI file.
CLEANFILES+= ${DOC}.tex-cjk
.endif
.endfor

# In "doc/share/mk/doc.project.mk", "doc.images.mk" and "doc.common.mk"
# is included before "doc.local.mk". Thus, we can use variables defined
# in these two files safely in XXX target:source declaration XXX.
# E.g. ${IMAGES_PDF}, ${LOCAL_IMAGES_EPS}
# ***********************************************************************
#  However, other files "doc.*.mk" are included after "doc.local.mk".
#  We CANNOT use their variables in XXX target:source declaration XXX !!!
# ***********************************************************************
# But no problems about using their variables in other places.
# Then, PMake expands variables just when they are ACTUALLY USED.


# Generate Chinese PDF
.if !target(${DOC}.pdf)
${DOC}.pdf: ${DOC}.tex-pdf ${IMAGES_PDF}
.for _curimage in ${IMAGES_PDF:M*share*}
	${CP} -p ${_curimage} ${.CURDIR:H:H}/${_curimage:H:S|${IMAGES_EN_DIR}/||:S|${.CURDIR}||}
.endfor
	${CJKTEXSTY} ${CJKTEXSTY_PDFTEX_FLAGS} < ${DOC}.tex-pdf > ${DOC}.tex-pdf-cjk

	-${PDFJADETEX_CMD} '${TEX_CMDSEQ} \nonstopmode\input{${DOC}.tex-pdf-cjk}'
	@${ECHO} "==> PDFTeX passed 1/3"
	-${PDFJADETEX_CMD} '${TEX_CMDSEQ} \nonstopmode\input{${DOC}.tex-pdf-cjk}'
	@${ECHO} "==> PDFTeX passed 2/3"
	-${PDFJADETEX_CMD} '${TEX_CMDSEQ} \nonstopmode\input{${DOC}.tex-pdf-cjk}'
	@${ECHO} "==> PDFTeX passed 3/3"
.endif

# Generate Chinese DVI, preparing for Chinese PostScript.
.if !target(${DOC}.dvi)
${DOC}.dvi: ${DOC}.tex ${LOCAL_IMAGES_EPS}
.for _curimage in ${LOCAL_IMAGES_EPS:M*share*}
	${CP} -p ${_curimage} ${.CURDIR:H:H}/${_curimage:H:S|${IMAGES_EN_DIR}/||:S|${.CURDIR}||}
.endfor
	${CJKTEXSTY} ${CJKTEXSTY_TEX_FLAGS} < ${DOC}.tex > ${DOC}.tex-cjk

	-${JADETEX_CMD} '${TEX_CMDSEQ} \nonstopmode\input{${DOC}.tex-cjk}'
	@${ECHO} "==> JadeTeX passed 1/3"
	-${JADETEX_CMD} '${TEX_CMDSEQ} \nonstopmode\input{${DOC}.tex-cjk}'
	@${ECHO} "==> JadeTeX passed 2/3"
	-${JADETEX_CMD} '${TEX_CMDSEQ} \nonstopmode\input{${DOC}.tex-cjk}'
	@${ECHO} "==> JadeTeX passed 3/3"
.endif

# For Chinese-specific switch "output.for.print".
print.index: ${SRCS} ${LOCAL_IMAGES_TXT}
	${INIT_INDEX_SGML_CMD}
	${JADE_CMD} -V html-index -V nochunks ${HTMLOPTS} -ioutput.html.images \
		-ioutput.for.print ${JADEOPTS} -t sgml ${MASTERDOC} > /dev/null
