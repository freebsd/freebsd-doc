# $FreeBSD: www/en/commercial/Makefile,v 1.16 2004/05/05 07:56:31 josef Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	commercial.sgml

INDEXLINK=	commercial.html

SRCS.DEFAULT=	../includes.xsl
XSLT.DEFAULT=	entries.xsl

XMLDOCS=	consult
PARAMS.consult=	--param pagename "'Consulting Services'"

XMLDOCS+=	consult_bycat::consult.xml:

XMLDOCS+=	hardware
PARAMS.hardware= --param pagename "'Hardware Vendors'"

XMLDOCS+=	isp
PARAMS.isp=	--param pagename "'Internet Service Providers'"

XMLDOCS+=	misc
PARAMS.misc=	--param pagename "'Miscellaneous Vendors'"

XMLDOCS+=	software
PARAMS.software=--param pagename "'Software Vendors'"

XMLDOCS+=	software_bycat:soft_bycat.xsl:software.xml:

lint:
	${XMLLINT} ${XMLLINTOPTS} --valid -o /dev/null ${.CURDIR}/consult.xml
	${XMLLINT} ${XMLLINTOPTS} --valid -o /dev/null ${.CURDIR}/hardware.xml
	${XMLLINT} ${XMLLINTOPTS} --valid -o /dev/null ${.CURDIR}/isp.xml
	${XMLLINT} ${XMLLINTOPTS} --valid -o /dev/null ${.CURDIR}/misc.xml
	${XMLLINT} ${XMLLINTOPTS} --valid -o /dev/null ${.CURDIR}/software.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"
