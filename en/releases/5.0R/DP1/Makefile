# $FreeBSD: www/en/releases/5.0R/DP1/Makefile,v 1.1 2002/04/05 22:30:14 bmah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml installation.sgml
DOCS+=	announce.sgml
# contents.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html
DATA+=	hardware-i386.html
DATA+=	hardware-sparc64.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html
DATA+=	relnotes-sparc64.html
DATA+=	installation-alpha.html
DATA+=	installation-i386.html
DATA+=	installation-sparc64.html
# DATA+=  cd1.txt cd2.txt cd3.txt cd4.txt

.include "${WEB_PREFIX}/share/mk/web.site.mk"
