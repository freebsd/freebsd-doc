# $FreeBSD: www/en/security/Makefile,v 1.8 2003/09/29 16:46:32 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=  
DOCS+=	security.sgml

INDEXLINK= security.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

CLEANFILES+= advisories.html.inc

security.html: advisories.html.inc

advisories.html.inc: mkindex.xsl ${XML_ADVISORIES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/mkindex.xsl ${XML_ADVISORIES}
