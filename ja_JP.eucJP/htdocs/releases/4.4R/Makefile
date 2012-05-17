# $FreeBSD: www/ja/releases/4.4R/Makefile,v 1.2 2002/01/30 13:29:10 kuriyama Exp $
# Original revision: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
#DOCS+=	hardware.sgml
DOCS+=	notes.sgml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

### Revision checking
REVCHECK=       YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
