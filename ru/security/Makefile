#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD: www/ru/security/Makefile,v 1.8 2009/12/24 06:49:01 bland Exp $
# $FreeBSDru: frdp/www/ru/security/Makefile,v 1.7 2004/01/25 15:18:18 andy Exp $
#
# Original revision: 1.18
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
DOCS+=	notices.sgml

advisories.sgml: advisories.html.inc

notices.sgml:	notices.html.inc

INDEXLINK=	security.html

DEPENDSET.DEFAULT=	advisories
DEPENDSET.errata-rss=	notices
DEPENDSET.notices=	notices
XML.DEFAULT=		${XML_ADVISORIES}

XMLDOCS=	advisories:mkindex.xsl::advisories.html.inc
PARAMS.advisories=	--param type "'advisory'"
NO_DATA.advisories=	yes
NO_TIDY.advisories=	yes

XMLDOCS+=	notices:mkindex.xsl::notices.html.inc
PARAMS.notices=		--param advisories.xml "'${XML_NOTICES}'"
PARAMS.notices+=	--param type "'notice'"
NO_DATA.notices=	yes
NO_TIDY.notices=	yes

XMLDOCS+=	advisories-rdf:security-rdf.xsl::advisories.rdf
XMLDOCS+=	advisories-rss:security-rss.xsl::rss.xml
XMLDOCS+=	errata-rss:errata-rss.xsl::errata.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"
