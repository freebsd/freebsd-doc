# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/security/Makefile,v 1.5 2003/10/20 07:18:47 andy Exp $
#
# Original revision: 1.8
 
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

advisories.html.inc: mkindex.xsl ../../en/security/advisories.xml
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/mkindex.xsl ${.CURDIR}/../../en/security/advisories.xml
