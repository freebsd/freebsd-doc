# $FreeBSD: www/Makefile,v 1.17 2001/02/25 12:00:45 alex Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.if make(obj)
SUBDIR+= ja es ru zh de
.endif
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
