# $FreeBSD: www/en/releases/5.0R/DP1/Makefile,v 1.4 2004/04/06 11:32:28 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
DOCS+=	hardware.sgml
DOCS+=	installation.sgml
DOCS+=	relnotes.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html
DATA+=	hardware-i386.html
DATA+=	hardware-sparc64.html
DATA+=	installation-alpha.html
DATA+=	installation-i386.html
DATA+=	installation-sparc64.html
DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html
DATA+=	relnotes-sparc64.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

XML_MIRRORS:=	${XML_MIRRORS:S@en@usr@}
