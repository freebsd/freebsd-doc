# $FreeBSD: www/zh/Makefile,v 1.2 1999/09/06 07:03:31 peter Exp $

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
DOCSUBDIR=	FAQ
.endif

SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr 
SGMLOPTS+=-e big5
FORMATS= "html ps"

WEBBASE=	/data

.include "../web.mk"

