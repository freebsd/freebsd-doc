# $FreeBSD: www/zh/Makefile,v 1.4 2000/02/28 12:51:21 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
DOCSUBDIR=	FAQ
.endif

SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr 
SGMLOPTS+=-e big5
FORMATS= "html ps"

WEBBASE=	/data/zh

.include "${WEB_PREFIX}/share/mk/web.site.mk"
