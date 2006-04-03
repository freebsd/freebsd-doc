# $FreeBSD: www/fr/security/Makefile,v 1.1 2003/12/15 16:04:58 stephane Exp $

# The FreeBSD French Documentation Project
# Original revision: 1.14

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=
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
