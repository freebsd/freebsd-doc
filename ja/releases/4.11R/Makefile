# $FreeBSD: www/ja/releases/4.11R/Makefile,v 1.3 2005/02/03 06:37:33 hrs Exp $
# Original revision: 1.3

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
#DOCS+=	schedule.sgml
#DOCS+=	todo.sgml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
#DATA+=	installation-alpha.html
#DATA+=	installation-i386.html
#DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
