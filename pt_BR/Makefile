# The FreeBSD Documentation Project
# The FreeBSD Brazilian Portuguese Documentation Project
#
# Based on: 1.105
#
# $FreeBSD: www/pt_BR/Makefile,v 1.1 2002/10/05 16:05:33 lioux Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# Subdirectories
# SGML
SUBDIR+= FAQ

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+=	doc
.endif

COOKIE=	FAQ

WEBDIR?=	data/pt_BR

.include "${WEB_PREFIX}/share/mk/web.site.mk"
