# $FreeBSD: www/zh/Makefile,v 1.6 2001/12/12 11:57:44 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR=	FAQ
.endif

WEBBASE=	/data/zh

.include "${WEB_PREFIX}/share/mk/web.site.mk"
