# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/security/Makefile,v 1.6 2003/11/27 14:01:08 den Exp $
#
# Original revision: 1.9
 
.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=   security.sgml
 
INDEXLINK=security.html
 
.include "${WEB_PREFIX}/share/mk/web.site.mk"

CLEANFILES+= advisories.html.inc

security.html: advisories.html.inc

advisories.html.inc: mkindex.xsl ${XML_ADVISORIES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/mkindex.xsl ${XML_ADVISORIES}
