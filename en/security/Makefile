# $FreeBSD: www/en/security/Makefile,v 1.12 2004/04/13 17:27:43 trhodes Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	charter.sgml
DOCS+=	security.sgml

INDEXLINK=	security.html
DATA+=		advisories.rdf
CLEANFILES+=	advisories.html.inc advisories.rdf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

security.html: advisories.html.inc advisories.rdf

advisories.html.inc: mkindex.xsl ${XML_ADVISORIES} ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param "advisories.xml" "'${XML_ADVISORIES}'" \
		${.CURDIR}/mkindex.xsl ${XML_ADVISORIES}
advisories.rdf: security-rdf.xsl ${XML_ADVISORIES} ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param "advisories.xml" "'${XML_ADVISORIES}'" \
		${.CURDIR}/security-rdf.xsl ${XML_ADVISORIES}
