# $FreeBSD: www/ja/security/Makefile,v 1.16 2004/01/10 18:38:00 rushani Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.11

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

advisories.html.inc: mkindex.xsl ${XML_ADVISORIES} ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param "advisories.xml" "'${XML_ADVISORIES}'" \
		${.CURDIR}/mkindex.xsl ${XML_ADVISORIES}
