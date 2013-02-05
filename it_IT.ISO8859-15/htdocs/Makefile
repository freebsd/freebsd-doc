# $FreeBSD$
.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.xml
DOCS+= community.xml
DOCS+= docs.xml
DOCS+= mailto.xml
DOCS+= support.xml
DOCS+= where.xml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=	--param pagename "'FreeBSD User Groups'"

# Subdirectories
# XML
SUBDIR=  copyright
SUBDIR+= docs
SUBDIR+= platforms
SUBDIR+= ports
SUBDIR+= releases
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
.endif

WEBDIR?=	data/it

.include "${DOC_PREFIX}/share/mk/web.site.mk"
