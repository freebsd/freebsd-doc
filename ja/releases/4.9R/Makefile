# $FreeBSD: www/ja/releases/4.9R/Makefile,v 1.1 2003/10/26 23:58:58 rushani Exp $
# Original revision: 1.4

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml
#DOCS=	hardware.sgml relnotes.sgml schedule.sgml todo.sgml qa.sgml
DOCS+=	announce.sgml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
