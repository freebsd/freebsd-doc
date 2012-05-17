# $FreeBSD: www/es/internal/Makefile,v 1.7 1999/09/06 07:03:02 peter Exp $

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

.include "${WEB_PREFIX}/share/mk/web.site.mk"
