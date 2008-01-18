# The FreeBSD Simplified Chinese Project
#
# $FreeBSD: www/zh_CN/releases/6.3R/Makefile,v 1.1 2008/01/17 21:00:00 delphij Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	relnotes.sgml
DOCS+=	hardware.sgml
DOCS+=	installation.sgml

DATA+=	errata.html
DATA+=	hardware-amd64.html
DATA+=	hardware-i386.html
DATA+=	installation-alpha.html
DATA+=	installation-amd64.html
DATA+=	installation-i386.html
DATA+=	installation-pc98.html
DATA+=	installation-powerpc.html
DATA+=	installation-sparc64.html
DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-amd64.html
DATA+=	relnotes-i386.html
DATA+=	relnotes-pc98.html
DATA+=	relnotes-powerpc.html
DATA+=	relnotes-sparc64.html

DATA+=	docbook.css

.include "${WEB_PREFIX}/share/mk/web.site.mk"
