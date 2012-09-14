# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	photos.sgml
DOCS+=	internal.sgml
DOCS+= 	about.sgml
DOCS+= 	machines.sgml
DOCS+= 	mirror.sgml
DOCS+=	statistic.sgml
DOCS+=	developer.sgml

INDEXLINK=	internal.html

DATA+=	README.mirror

.include "${DOC_PREFIX}/share/mk/web.site.mk"
