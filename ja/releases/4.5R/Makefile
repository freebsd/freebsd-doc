# $FreeBSD: www/ja/releases/4.5R/Makefile,v 1.1 2002/01/30 13:20:35 kuriyama Exp $
# Original revision: 1.5

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	hardware.sgml notes.sgml qa.sgml announce.sgml schedule.sgml
DOCS=	announce.sgml notes.sgml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

### Revision checking
REVCHECK=       YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
