# $FreeBSD: www/en/releases/5.2.1R/Makefile,v 1.3 2004/04/05 23:52:13 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml
DOCS+=	announce.sgml
DOCS+=  installation.sgml

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
DATA+=  installation-alpha.html
DATA+=  installation-amd64.html
DATA+=  installation-ia64.html
DATA+=  installation-i386.html
DATA+=  installation-pc98.html
DATA+=  installation-sparc64.html
DATA+=  readme.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
