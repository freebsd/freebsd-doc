# $FreeBSD: www/Makefile,v 1.16 2000/11/30 00:03:37 kuriyama Exp $

WEB_PREFIX=	${.CURDIR}

SUBDIR= en

.if make(obj)
SUBDIR+= ja es ru zh de
.endif

links:

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
