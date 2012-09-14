# $FreeBSD$
# Original revision: 1.4

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
DOCS+=	hardware.sgml
#DOCS+=	installation.sgml
DOCS+=	relnotes.sgml
#DOCS+=	schedule.sgml
#DOCS+=	todo.sgml
#DOCS+=	errata_policy.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html
DATA+=	hardware-i386.html
#DATA+=	installation-alpha.html
#DATA+=	installation-i386.html
#DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"
