# $FreeBSD: www/ja/releases/4.6.2R/Makefile,v 1.1 2002/08/17 20:31:10 hrs Exp $
# Original revision: 1.4

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
DOCS+=	hardware.sgml
DOCS+=	relnotes.sgml

DATA=	docbook.css
#DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
#+DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

### Revision checking
REVCHECK=       YES

.include "${DOC_PREFIX}/share/mk/web.site.mk"
