# $FreeBSD: doc/Makefile,v 1.19 2000/08/06 17:04:17 alex Exp $
#
# The user can override the default list of languages to build and install
# with the DOC_LANG variable.
# 
.if defined(DOC_LANG) && !empty(DOC_LANG)
SUBDIR = 	${DOC_LANG}
.else
SUBDIR =	en_US.ISO_8859-1
SUBDIR+=	de_DE.ISO_8859-1
SUBDIR+=	es_ES.ISO_8859-1
SUBDIR+=	fr_FR.ISO_8859-1
SUBDIR+=	ja_JP.eucJP
SUBDIR+=	ru_RU.KOI8-R
SUBDIR+=	zh_TW.Big5
.endif

DOC_PREFIX?=   ${.CURDIR}

.if defined(SUPHOST)
SUPFLAGS+=	-h ${SUPHOST}
.endif
update:
.if defined(SUP_UPDATE)
.if !defined(DOCSUPFILE)
	@echo "Error: Please define DOCSUPFILE before doing make update."
	@exit 1
.endif
	@echo "--------------------------------------------------------------"
	@echo ">>> Running ${SUP}"
	@echo "--------------------------------------------------------------"
	@${SUP} ${SUPFLAGS} ${DOCSUPFILE}
.elif defined(CVS_UPDATE)
	@echo "--------------------------------------------------------------"
	@echo ">>> Updating ${.CURDIR} from cvs repository" ${CVSROOT}
	@echo "--------------------------------------------------------------"
	cd ${.CURDIR}; cvs -q update -P -d
.else
	@echo "Error: Please define either SUP_UPDATE or CVS_UPDATE first."
.endif

.include "${DOC_PREFIX}/share/mk/doc.subdir.mk"
