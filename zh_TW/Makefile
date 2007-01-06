# $FreeBSD: www/zh_TW/Makefile,v 1.2 2006/07/12 17:10:59 hrs Exp $
# Original revision: 

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.
DOCS=  about.sgml
#DOCS+= applications.sgml
DOCS+= art.sgml
DOCS+= availability.sgml
DOCS+= community.sgml
DOCS+= docs.sgml
DOCS+= send-pr.sgml

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+=	doc
.endif

WEBDIR?=	data/zh_TW

DATESUBST?=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"上次更新： \1">/'

.include "${WEB_PREFIX}/share/mk/web.site.mk"
