# The FreeBSD Documentation Project
# The FreeBSD Brazilian Portuguese Documentation Project
#
# $FreeBSD$

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
FORMATS=	"html ps"

.include "${WEB_PREFIX}/share/mk/web.site.mk"
