# $FreeBSD$

###################################################
# The FreeBSD Mongolian Documentation Project     #
###################################################

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR=	doc
.endif

WEBDIR?=	data/mn

.include "${DOC_PREFIX}/share/mk/web.site.mk"
