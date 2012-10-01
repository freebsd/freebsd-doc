# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# DOCS=	hardware.xml notes.xml qa.xml announce.xml schedule.xml
# DOCS+=	contents.xml
DOCS= notes.xml announce.xml

DATA=	docbook.css
DATA+=	errata.html
# DATA+=	hardware-alpha.html
# DATA+=	hardware-i386.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html
# DATA+=  cd1.txt cd2.txt cd3.txt cd4.txt

.include "${DOC_PREFIX}/share/mk/web.site.mk"
