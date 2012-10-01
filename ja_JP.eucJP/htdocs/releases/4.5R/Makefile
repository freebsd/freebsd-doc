# $FreeBSD$
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.xml
DOCS+=	contents.xml
DOCS+=	hardware.xml
DOCS+=	notes.xml
DOCS+=	qa.xml
DOCS+=	schedule.xml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

#DATA+=  cd1.txt cd2.txt cd3.txt cd4.txt

.include "${DOC_PREFIX}/share/mk/web.site.mk"
