# $FreeBSD: www/en/security/Makefile,v 1.9 2003/11/24 18:26:33 hrs Exp $

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

advisories.html.inc: mkindex.xsl ${XML_ADVISORIES} ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param "ftpbase" "'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/'" \
		--param "ftpbaseold" "'ftp://ftp.FreeBSD.org/pub/FreeBSD/CERT/advisories/old/'" \
		${.CURDIR}/mkindex.xsl ${XML_ADVISORIES}
