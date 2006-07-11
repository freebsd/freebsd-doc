# The FreeBSD Simplified Chinese Project
# Original Revision: 1.7
#
# $FreeBSD: www/zh_CN/releases/6.0R/Makefile,v 1.1.1000.1 2005/12/22 17:53:13 delphij Exp $

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
DATA+=	installation-ia64.html
DATA+=	installation-i386.html
DATA+=	installation-pc98.html
DATA+=	installation-sparc64.html
DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-amd64.html
DATA+=	relnotes-ia64.html
DATA+=	relnotes-i386.html
DATA+=	relnotes-pc98.html
DATA+=	relnotes-sparc64.html

DATA+=	docbook.css

.include "${WEB_PREFIX}/share/mk/web.site.mk"
