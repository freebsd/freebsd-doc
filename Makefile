# The user can override the default list of languages to build and install
# with the DOC_LANG variable.
#
.if defined(ENGLISH_ONLY) && !empty(ENGLISH_ONLY)
DOC_LANG=	en_US.ISO8859-1
.endif

.if defined(DOC_LANG) && !empty(DOC_LANG)
SUBDIR = 	${DOC_LANG}
.else
SUBDIR =	en_US.ISO8859-1
SUBDIR+=	bn_BD.UTF-8
SUBDIR+=	da_DK.ISO8859-1
SUBDIR+=	de_DE.ISO8859-1
SUBDIR+=	el_GR.ISO8859-7
SUBDIR+=	es_ES.ISO8859-1
SUBDIR+=	fr_FR.ISO8859-1
SUBDIR+=	hu_HU.ISO8859-2
SUBDIR+=	it_IT.ISO8859-15
SUBDIR+=	ja_JP.eucJP
SUBDIR+=	ko_KR.UTF-8
SUBDIR+=	mn_MN.UTF-8
SUBDIR+=	nl_NL.ISO8859-1
SUBDIR+=	pl_PL.ISO8859-2
SUBDIR+=	pt_BR.ISO8859-1
SUBDIR+=	ru_RU.KOI8-R
SUBDIR+=	tr_TR.ISO8859-9
SUBDIR+=	zh_CN.UTF-8
SUBDIR+=	zh_TW.UTF-8
.endif

SUBDIR+=	share

DOC_PREFIX?=   ${.CURDIR}

GIT?=		/usr/local/bin/git

update:
.if !exists(${GIT})
	@${ECHODIR} "--------------------------------------------------------------"
	@${ECHODIR} ">>> ${GIT} is required to update ${.CURDIR}"
	@${ECHODIR} "--------------------------------------------------------------"
	@${EXIT}
.else
	@${ECHODIR} "--------------------------------------------------------------"
	@${ECHODIR} ">>> Updating ${.CURDIR} from git repository"
	@${ECHODIR} "--------------------------------------------------------------"
	cd ${.CURDIR}; ${GIT} pull --ff-only
.endif

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
