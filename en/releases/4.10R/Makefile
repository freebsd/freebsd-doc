# $FreeBSD: www/en/releases/4.10R/Makefile,v 1.2 2004/04/06 11:32:27 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	announce.sgml
DOCS+=	hardware.sgml
DOCS+=	installation.sgml
DOCS+=	relnotes.sgml
DOCS+=	qa.sgml
DOCS+=	schedule.sgml
DOCS+=	todo.sgml

DATA=	docbook.css
#DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
#DATA+=	installation-alpha.html
#DATA+=	installation-i386.html
#DATA+=	readme.html
#DATA+=	relnotes-alpha.html
#DATA+=	relnotes-i386.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
