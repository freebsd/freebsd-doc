# $FreeBSD: www/Makefile,v 1.15 2000/11/08 01:15:39 kuriyama Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if make(obj)
SUBDIR+= ja es ru zh
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
