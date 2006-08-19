# $FreeBSD: www/de/security/Makefile,v 1.5 2004/07/15 14:34:20 brueffer Exp $
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

security.html: advisories.html.inc

DEPENDSET.DEFAULT=	advisories
XML.DEFAULT=		${XML_ADVISORIES}

XMLDOCS=	advisories:mkindex.xsl::advisories.html.inc
NO_DATA.advisories=	yes
NO_TIDY.advisories=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"
