# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.xml
DOCS+=	hardware.xml
DOCS+=	installation.xml
DOCS+=	relnotes.xml
DOCS+=	schedule.xml
DOCS+=	todo.xml
DOCS+=	errata_policy.xml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html
DATA+=	hardware-i386.html
DATA+=	installation-alpha.html
DATA+=	installation-i386.html
DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"
