# $FreeBSD$
#
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
SUBDIR+=	bn_BD.ISO10646-1
SUBDIR+=	da_DK.ISO8859-1
SUBDIR+=	de_DE.ISO8859-1
SUBDIR+=	el_GR.ISO8859-7
SUBDIR+=	es_ES.ISO8859-1
SUBDIR+=	fr_FR.ISO8859-1
SUBDIR+=	hu_HU.ISO8859-2
SUBDIR+=	it_IT.ISO8859-15
SUBDIR+=	ja_JP.eucJP
SUBDIR+=	mn_MN.UTF-8
SUBDIR+=	nl_NL.ISO8859-1
SUBDIR+=	pl_PL.ISO8859-2
SUBDIR+=	pt_BR.ISO8859-1
SUBDIR+=	ru_RU.KOI8-R
SUBDIR+=	sr_YU.ISO8859-2
SUBDIR+=	tr_TR.ISO8859-9
SUBDIR+=	zh_CN.GB2312
SUBDIR+=	zh_TW.Big5
.endif

DOC_PREFIX?=   ${.CURDIR}

SVN?=		/usr/local/bin/svn

update:
.if !exists(${SVN})
	@${ECHODIR} "--------------------------------------------------------------"
	@${ECHODIR} ">>> ${SVN} is required to update ${.CURDIR}"
	@${ECHODIR} "--------------------------------------------------------------"
	@${EXIT}
.else
	@${ECHODIR} "--------------------------------------------------------------"
	@${ECHODIR} ">>> Updating ${.CURDIR} from svn repository"
	@${ECHODIR} "--------------------------------------------------------------"
	cd ${.CURDIR}; ${SVN} update
.endif

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
