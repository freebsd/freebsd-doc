# $FreeBSD: www/Makefile,v 1.23 2003/12/05 19:58:36 blackend Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.if make(obj)
SUBDIR+= da de es fr it ja pt_BR ru tr zh
.endif
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
