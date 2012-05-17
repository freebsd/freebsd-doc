# $FreeBSD: www/it/Makefile,v 1.13 2006/06/06 11:08:49 ale Exp $
.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
DOCS+= community.sgml
DOCS+= docs.sgml
DOCS+= mailto.sgml
DOCS+= support.sgml
DOCS+= where.sgml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=	--param pagename "'FreeBSD User Groups'"

# Subdirectories
# SGML
SUBDIR=  copyright
SUBDIR+= docs
SUBDIR+= platforms
SUBDIR+= ports
SUBDIR+= releases
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
.endif

WEBDIR?=	data/it

.include "${WEB_PREFIX}/share/mk/web.site.mk"
