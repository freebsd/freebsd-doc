# $FreeBSD: www/ja/releases/4.5R/Makefile,v 1.3 2002/02/17 03:46:27 kuriyama Exp $
# Original revision: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	hardware.sgml notes.sgml qa.sgml announce.sgml schedule.sgml
DOCS=	hardware.sgml notes.sgml announce.sgml
DOCS+=	contents.sgml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html
#DATA+=  cd1.txt cd2.txt cd3.txt cd4.txt

### Revision checking
REVCHECK=       YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
