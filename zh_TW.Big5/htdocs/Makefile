# $FreeBSD$
# Original revision:

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
DOCS+= applications.sgml
DOCS+= art.sgml
DOCS+= availability.sgml
DOCS+= community.sgml
DOCS+= docs.sgml
DOCS+= logo.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml

#XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
#DEPENDSET.index=transtable mirrors news press events \
#		advisories notices

#XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
#DEPENDSET.usergroups=transtable usergroups
#PARAMS.usergroups=	--param pagename "'FreeBSD User Groups'"

# Subdirectories
# SGML
SUBDIR+= docs

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+=	doc
.endif

# Non-SGML
SUBDIR+= layout

WEBDIR?=	data/zh_TW

DATESUBST?=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"上次更新： \1">/'

.include "${DOC_PREFIX}/share/mk/web.site.mk"
