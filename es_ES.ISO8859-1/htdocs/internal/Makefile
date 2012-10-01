# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	photos.xml
DOCS+=	internal.xml
DOCS+= 	about.xml
DOCS+= 	machines.xml
DOCS+= 	mirror.xml
DOCS+=	statistic.xml
DOCS+=	developer.xml

INDEXLINK=	internal.html

DATA+=	README.mirror

.include "${DOC_PREFIX}/share/mk/web.site.mk"
