#
# %SOURCE%	en/security/Makefile
# %SRCID%	1.17
#
# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS =	security.sgml
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
