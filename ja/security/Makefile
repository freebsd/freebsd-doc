# $FreeBSD: www/ja/security/Makefile,v 1.17 2004/01/19 17:19:34 hrs Exp $
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

security.html: advisories.html.inc

DEPENDSET.DEFAULT=	advisories
XML.DEFAULT=		${XML_ADVISORIES}

XMLDOCS=	advisories:mkindex.xsl::advisories.html.inc
NO_DATA.advisories=	yes
NO_TIDY.advisories=	yes

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
