# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# DOCS=	hardware.sgml notes.sgml qa.sgml announce.sgml schedule.sgml
# DOCS+=	contents.sgml
DOCS= notes.sgml announce.sgml

DATA=	docbook.css
DATA+=	errata.html
# DATA+=	hardware-alpha.html
# DATA+=	hardware-i386.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html
# DATA+=  cd1.txt cd2.txt cd3.txt cd4.txt

.include "${WEB_PREFIX}/share/mk/web.site.mk"
