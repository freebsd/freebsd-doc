# $FreeBSD: www/Makefile,v 1.19 2002/10/05 16:06:44 lioux Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.if make(obj)
SUBDIR+= it ja es ru zh de pt_BR
.endif
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
