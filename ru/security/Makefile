#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/security/Makefile,v 1.7 2004/01/25 15:18:18 andy Exp $
#
# Original revision: 1.11
#
 
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
		--param "advisories.xml" "'${XML_ADVISORIES}'" \
		${.CURDIR}/mkindex.xsl ${XML_ADVISORIES}
