#
# $FreeBSD$
#
# This include file <doc.translate.mk> handles building and installing of
# DocBook documentation translations in the FreeBSD Documentation Project.
#

# ------------------------------------------------------------------------
#
# Document-specific variables
# [...]
#

# translation -------------------------------------------------------

# Master English document
MASTERDOC_EN?=	${MASTERDOC:S/${LANGCODE}/en_US.ISO8859-1/}
TRAN_DIR?=	${MASTERDOC:H}
EN_DIR?=	${TRAN_DIR:S/${LANGCODE}/en_US.ISO8859-1/}
PO_LANG?=	${LANGCODE:C/\..*$//}
PO_CHARSET?=	${LANGCODE:tl:C/^.*\.//:S/^iso/iso-/:S/utf-8/UTF-8/}
CLEANFILES+=	${DOC}.translate.xml ${PO_LANG}.mo

PO_CATALOG_FILES=	file://${EN_DIR}/catalog-cwd.xml \
                        file://${EN_DIR:H:H}/share/xml/catalog.xml \
                        file://${DOC_PREFIX}/share/xml/catalog.xml \
                        file://${LOCALBASE}/share/xml/catalog
.if defined(EXTRA_CATALOGS)
PO_CATALOG_FILES+=     ${EXTRA_CATALOGS}
.endif
PO_XMLLINT=	env XML_CATALOG_FILES="${PO_CATALOG_FILES}" ${PREFIX}/bin/xmllint

# fix settings in PO file
IDSTR1=		$$Free
IDSTR2=		BSD$$
POSET_CMD=	${SED} -i '' -e '1s,^,\#${IDSTR1}${IDSTR2}\${.newline},' \
			     -e 's,^\(\"Language-Team:.*\\n\"\),\1\${.newline}\"Language: ${PO_LANG}\\n\",' \
			     -e 's,^\"Content-Type: text/plain; charset=.*\\n,\"Content-Type: text/plain; charset=${PO_CHARSET}\\n,'

.if ${.TARGETS:Mpo} || ${.TARGETS:Mtran} || ${.TARGETS:M${DOC}.translate.xml}

MASTER_SRCS!=	${MAKE} -C ${EN_DIR} -V SRCS

${DOC}.translate.xml:
	@if [ "${TRAN_DIR}" == "${EN_DIR}" ]; then \
		${ECHO} "build PO file in a non-English dir" ; \
		exit 1 ; \
	 fi
	# some SRCS files might need to be generated, make sure they exist
	@${MAKE} -C ${EN_DIR} ${MASTER_SRCS} > /dev/null
	# normalize the English original into a single file
	@${PO_XMLLINT} --nonet --noent --valid --xinclude ${MASTERDOC_EN} > ${.TARGET}.tmp
	# remove redundant namespace attributes
	@${PO_XMLLINT} --nsclean ${.TARGET}.tmp > ${.TARGET}
	@${RM} ${.TARGET}.tmp
	@${MAKE} -C ${EN_DIR} clean > /dev/null

po: ${PO_LANG}.po
.PHONY:	po
${PO_LANG}.po:	${DOC}.translate.xml
	@${ITSTOOL} -o ${PO_LANG}.po.tmp ${DOC}.translate.xml
	@( if [ -f "${PO_LANG}.po" ]; then \
		echo "${PO_LANG}.po exists, merging" ; \
		${MSGMERGE} -o ${PO_LANG}.po.new ${PO_LANG}.po ${PO_LANG}.po.tmp ; \
		${MSGATTRIB} --no-obsolete -o ${PO_LANG}.po.new ${PO_LANG}.po ; \
		${MV} ${PO_LANG}.po.new ${PO_LANG}.po ; \
		${RM} ${PO_LANG}.po.tmp ${DOC}.translate.xml ; \
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


