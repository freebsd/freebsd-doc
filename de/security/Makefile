# $FreeBSD$
# $FreeBSDde: de-www/security/Makefile,v 1.5 2004/07/04 13:38:58 brueffer Exp $
# basiert auf: 1.13

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
