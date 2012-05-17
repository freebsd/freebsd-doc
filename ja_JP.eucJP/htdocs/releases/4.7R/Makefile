# $FreeBSD: www/ja/releases/4.7R/Makefile,v 1.2 2002/11/02 08:24:19 hrs Exp $
# Original revision: 1.10

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
DOCS+=	hardware.sgml
#DOCS+=	installation.sgml
#DOCS+=	qa.sgml
DOCS+=	relnotes.sgml
#DOCS+=	schedule.sgml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	installation-alpha.html
#DATA+=	installation-i386.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
#DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

#DATA+=  CHECKSUM-i386.MD5

### Revision checking
REVCHECK=       YES

.include "${DOC_PREFIX}/share/mk/web.site.mk"
