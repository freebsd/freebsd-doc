# $FreeBSD: www/ja/security/Makefile,v 1.13 2000/11/07 11:38:09 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.8

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=  
DOCS+=	security.sgml

INDEXLINK= security.html

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"

CLEANFILES+= advisories.html.inc

security.html: advisories.html.inc

advisories.html.inc: mkindex.xsl ../../en/security/advisories.xml
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/mkindex.xsl ${.CURDIR}/../../en/security/advisories.xml
