# $FreeBSD: www/ja/releases/4.4R/Makefile,v 1.1 2001/09/29 21:59:41 hrs Exp $
# Original revision: 1.5

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	announce.sgml hardware.sgml notes.sgml
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
