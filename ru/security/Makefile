#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD: www/ru/security/Makefile,v 1.7 2006/08/19 21:25:55 hrs Exp $
# $FreeBSDru: frdp/www/ru/security/Makefile,v 1.7 2004/01/25 15:18:18 andy Exp $
#
# Original revision: 1.17
#
 
.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=
DOCS+=	security.sgml
DOCS+=	advisories.sgml

advisories.sgml: advisories.html.inc

INDEXLINK=	security.html

security.html: advisories.html.inc advisories.rdf

DEPENDSET.DEFAULT=	advisories
DEPENDSET.errata-rss=	notices
XML.DEFAULT=		${XML_ADVISORIES}

XMLDOCS=	advisories:mkindex.xsl::advisories.html.inc
NO_DATA.advisories=	yes
NO_TIDY.advisories=	yes

XMLDOCS+=	advisories-rdf:security-rdf.xsl::advisories.rdf
XMLDOCS+=	advisories-rss:security-rss.xsl::rss.xml
XMLDOCS+=	errata-rss:errata-rss.xsl::errata.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"
