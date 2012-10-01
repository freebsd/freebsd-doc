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

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html
DATA+=	hardware-i386.html
DATA+=	hardware-sparc64.html
DATA+=	installation-alpha.html
DATA+=	installation-i386.html
DATA+=	installation-sparc64.html
DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html
DATA+=	relnotes-sparc64.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"

XML_MIRRORS:=	${XML_MIRRORS:S@en@usr@}
