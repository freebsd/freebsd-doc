#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD: www/ru/security/Makefile,v 1.6 2004/01/26 07:24:12 andy Exp $
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

security.html: advisories.html.inc

DEPENDSET.DEFAULT=	advisories
XML.DEFAULT=		${XML_ADVISORIES}

XMLDOCS=	advisories:mkindex.xsl::advisories.html.inc
NO_DATA.advisories=	yes
NO_TIDY.advisories=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"
