# $FreeBSD: www/Makefile,v 1.22 2003/11/14 21:02:53 blackend Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.if make(obj)
SUBDIR+= da de es fr it ja pt_BR ru zh
.endif
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
