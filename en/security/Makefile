# $FreeBSD: www/en/security/Makefile,v 1.11 2004/01/17 18:58:07 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	charter.sgml
DOCS+=	security.sgml

INDEXLINK= security.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

CLEANFILES+= advisories.html.inc

security.html: advisories.html.inc

advisories.html.inc: mkindex.xsl ${XML_ADVISORIES} ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param "advisories.xml" "'${XML_ADVISORIES}'" \
		${.CURDIR}/mkindex.xsl ${XML_ADVISORIES}
