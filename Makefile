# $FreeBSD: www/Makefile,v 1.20 2003/03/20 00:10:51 trhodes Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.if make(obj)
SUBDIR+= da it ja es ru zh de pt_BR
.endif
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
