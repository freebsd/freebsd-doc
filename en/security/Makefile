# $FreeBSD: www/en/security/Makefile,v 1.13 2004/05/25 01:19:50 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	charter.sgml
DOCS+=	security.sgml

INDEXLINK=	security.html

security.html: advisories.html.inc advisories.rdf

DEPENDSET.DEFAULT=	advisories
XML.DEFAULT=		${XML_ADVISORIES}

XMLDOCS=	advisories:mkindex.xsl::advisories.html.inc
NO_DATA.advisories=	yes
NO_TIDY.advisories=	yes

XMLDOCS+=	advisories-rdf:security-rdf.xsl::advisories.rdf

.include "${WEB_PREFIX}/share/mk/web.site.mk"
