# $FreeBSD: www/ja/releases/4.10R/Makefile,v 1.2 2004/05/27 07:36:54 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
DOCS+=	hardware.sgml
#DOCS+=	installation.sgml
DOCS+=	relnotes.sgml
#DOCS+=	qa.sgml
#DOCS+=	schedule.sgml
#DOCS+=	todo.sgml

DATA=	docbook.css
#DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
#DATA+=	installation-alpha.html
#DATA+=	installation-i386.html
#DATA+=	readme.html
#DATA+=	relnotes-alpha.html
#DATA+=	relnotes-i386.html

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
