# $FreeBSD: www/Makefile,v 1.18 2001/04/25 18:01:30 wosch Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.if make(obj)
SUBDIR+= ja es ru zh de pt_BR
.endif
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
