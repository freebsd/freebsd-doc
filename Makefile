# $FreeBSD: www/Makefile,v 1.21 2003/10/28 23:04:04 simon Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.if make(obj)
SUBDIR+= da fr it ja es ru zh de pt_BR
.endif
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
