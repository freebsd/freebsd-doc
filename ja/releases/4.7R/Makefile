# $FreeBSD: www/ja/releases/4.7R/Makefile,v 1.1 2002/10/11 12:37:31 hrs Exp $
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
DOCS+=	hardware.sgml relnotes.sgml
#DOCS+=	hardware.sgml relnotes.sgml schedule.sgml qa.sgml announce.sgml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html
#DATA+=  CHECKSUM-i386.MD5

### Revision checking
REVCHECK=       YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
