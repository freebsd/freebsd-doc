# The FreeBSD German Documentation Project
# The FreeBSD Documentation Project
# $FreeBSD$
# $FreeBSDde: de-www/releases/4.8R/Makefile,v 1.1 2003/08/02 09:31:50 mheinen Exp $
# basiert auf: 1.4

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
