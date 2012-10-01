# The FreeBSD German Documentation Project
# The FreeBSD Documentation Project
# $FreeBSD$
# $FreeBSDde: de-www/releases/4.8R/Makefile,v 1.3 2004/05/16 22:09:33 mheinen Exp $
# basiert auf: 1.7

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
DATA+=	installation-alpha.html
DATA+=	installation-i386.html
DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"
