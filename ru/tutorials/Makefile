# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/tutorials/Makefile,v 1.3 2000/11/10 17:03:46 phantom Exp $
# Original revision: 1.9
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS = index.sgml

DIRS_TO_CLEAN =../../../doc/ru_RU.KOI8-R/books/porters-handbook
#		../../../doc/ru_RU.KOI8-R/articles \
#		../../../doc/ru_RU.KOI8-R/books/fdp-primer \
#		../../../doc/ru_RU.KOI8-R/books/ppp-primer

all afterinstall: index.html
	(cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R/books/porters-handbook && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/porters-handbook ${.TARGET:S/afterinstall/install/})
#	(cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R/articles && ${MAKE} 'FORMATS=html html-split' 'DESTDIR=${DESTDIR}/data/tutorials/$${.CURDIR:T}' ${.TARGET:S/afterinstall/install/})
#	(cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R/books/fdp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/docproj-primer ${.TARGET:S/afterinstall/install/})
#	(cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R/books/ppp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/ppp ${.TARGET:S/afterinstall/install/})

.include "${WEB_PREFIX}/share/mk/web.site.mk"
