# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml

DATA=	docbook.css
DATA+=  errata.html
DATA+=  early-adopter.html
DATA+=  hardware-alpha.html
DATA+=  hardware-amd64.html
DATA+=  hardware-ia64.html
DATA+=  hardware-i386.html
DATA+=  hardware-pc98.html
DATA+=  hardware-sparc64.html
DATA+=  relnotes-alpha.html
DATA+=  relnotes-amd64.html
DATA+=  relnotes-ia64.html
DATA+=  relnotes-i386.html
DATA+=  relnotes-pc98.html
DATA+=  relnotes-sparc64.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
