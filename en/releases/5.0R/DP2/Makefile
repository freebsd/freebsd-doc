# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml installation.sgml
# DOCS+=	announce.sgml
# contents.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	early-adopter.html
DATA+=	hardware-alpha.html
DATA+=	hardware-i386.html
DATA+=	hardware-pc98.html
DATA+=	hardware-sparc64.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html
DATA+=	relnotes-pc98.html
DATA+=	relnotes-sparc64.html
DATA+=	installation-alpha.html
DATA+=	installation-i386.html
DATA+=	installation-pc98.html
DATA+=	installation-sparc64.html
# DATA+=  cd1.txt cd2.txt cd3.txt cd4.txt

.include "${WEB_PREFIX}/share/mk/web.site.mk"
