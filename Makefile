# $FreeBSD$
#
# The user can override the default list of languages to build and install
# with the DOC_LANG variable.
# 
.if defined(DOC_LANG) && !empty(DOC_LANG)
SUBDIR = 	${DOC_LANG}
.else
SUBDIR =	en_US.ISO8859-1
SUBDIR+=	bn_BD.ISO10646-1
SUBDIR+=	da_DK.ISO8859-1
SUBDIR+=	de_DE.ISO8859-1
SUBDIR+=	el_GR.ISO8859-7
SUBDIR+=	es_ES.ISO8859-1
SUBDIR+=	fr_FR.ISO8859-1
SUBDIR+=	it_IT.ISO8859-15
SUBDIR+=	ja_JP.eucJP
SUBDIR+=	pl_PL.ISO8859-2
SUBDIR+=	pt_BR.ISO8859-1
SUBDIR+=	ru_RU.KOI8-R
SUBDIR+=	sr_YU.ISO8859-2
SUBDIR+=	tr_TR.ISO8859-9
SUBDIR+=	zh_TW.Big5
.endif

DOC_PREFIX?=   ${.CURDIR}

SUP?=		${PREFIX}/bin/cvsup
SUPFLAGS?=	-g -L 2 -P -
.if defined(SUPHOST)
SUPFLAGS+=	-h ${SUPHOST}
.endif

CVS?=		/usr/bin/cvs
CVSFLAGS?=	-R -q

update:
.if defined(SUP_UPDATE)
.if !defined(DOCSUPFILE)
	@${ECHO_CMD} "Error: Please define DOCSUPFILE before doing make update."
	@exit 1
.endif
	@${ECHODIR} "--------------------------------------------------------------"
	@${ECHODIR} ">>> Running ${SUP}"
	@${ECHODIR} "--------------------------------------------------------------"
	@${SUP} ${SUPFLAGS} ${DOCSUPFILE}
.elif defined(CVS_UPDATE)
	@${ECHODIR} "--------------------------------------------------------------"
	@${ECHODIR} ">>> Updating ${.CURDIR} from cvs repository" ${CVSROOT}
	@${ECHODIR} "--------------------------------------------------------------"
	cd ${.CURDIR}; ${CVS} ${CVSFLAGS} update -P -d
.else
	@${ECHO_CMD} "Error: Please define either SUP_UPDATE or CVS_UPDATE first."
.endif

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
