# $FreeBSD$
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

WEBBASE?=	/data/zh_TW

.include "${WEB_PREFIX}/share/mk/web.site.mk"
