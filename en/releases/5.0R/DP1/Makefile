# $FreeBSD: www/en/releases/4.5R/Makefile,v 1.6 2002/01/30 14:25:02 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml installation.sgml 
# DOCS+=	announce.sgml contents.sgml

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
