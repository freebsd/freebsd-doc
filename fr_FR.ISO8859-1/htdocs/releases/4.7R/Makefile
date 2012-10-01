# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# DOCS=	hardware.xml relnotes.xml schedule.xml qa.xml announce.xml
DOCS= announce.xml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html hardware-i386.html
# DATA+=	relnotes-alpha.html relnotes-i386.html
# DATA+=  CHECKSUM-i386.MD5

.include "${DOC_PREFIX}/share/mk/web.site.mk"
