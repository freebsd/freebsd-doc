# $FreeBSD: www/zh/Makefile,v 1.3 1999/12/17 14:16:56 phantom Exp $

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
DOCSUBDIR=	FAQ
.endif

SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr 
SGMLOPTS+=-e big5
FORMATS= "html ps"

WEBBASE=	/data/zh

.include "../web.mk"

