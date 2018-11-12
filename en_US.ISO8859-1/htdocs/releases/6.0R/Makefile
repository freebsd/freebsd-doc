# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	todo.xml schedule.xml approvals.xml
DOCS+=	announce.xml
DOCS+=	relnotes.xml
DOCS+=	hardware.xml
DOCS+=	installation.xml

DATA+=	errata.html
DATA+=	hardware-alpha.html
DATA+=	hardware-amd64.html
DATA+=	hardware-ia64.html
DATA+=	hardware-i386.html
DATA+=	hardware-pc98.html
DATA+=	hardware-sparc64.html
DATA+=	installation-alpha.html
DATA+=	installation-amd64.html
DATA+=	installation-ia64.html
DATA+=	installation-i386.html
DATA+=	installation-pc98.html
DATA+=	installation-sparc64.html
DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-amd64.html
DATA+=	relnotes-ia64.html
DATA+=	relnotes-i386.html
DATA+=	relnotes-pc98.html
DATA+=	relnotes-sparc64.html

DATA+=	docbook.css

.include "${DOC_PREFIX}/share/mk/web.site.mk"
