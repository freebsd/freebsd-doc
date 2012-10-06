# The FreeBSD Documentation Project
# The FreeBSD Brazilian Portuguese Documentation Project
#
# Based on: 1.105
#
# $FreeBSD$

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# Subdirectories
# XML
SUBDIR+= FAQ

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+=	doc
.endif

WEBDIR?=	data/pt_BR

.include "${DOC_PREFIX}/share/mk/web.site.mk"
