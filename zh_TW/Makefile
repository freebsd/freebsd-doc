# $FreeBSD: www/zh_TW/Makefile,v 1.1 2006/07/11 13:24:04 hrs Exp $
# Original revision: 

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+=	doc
.endif

WEBDIR?=	data/zh_TW

.include "${WEB_PREFIX}/share/mk/web.site.mk"
