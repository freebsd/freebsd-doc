# $FreeBSD: www/zh/Makefile,v 1.5 2000/11/07 05:20:40 kuriyama Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
DOCSUBDIR=	FAQ
.endif

SGMLFLAGS+=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr
SGMLFLAGS+=	-e big5
FORMATS=	"html ps"

WEBBASE=	/data/zh

.include "${WEB_PREFIX}/share/mk/web.site.mk"
