#
# $FreeBSD: www/en/tutorials/Makefile,v 1.10 2000/11/07 04:05:37 kuriyama Exp $
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

DIRS_TO_CLEAN =	../../../doc/en_US.ISO8859-1/articles \
		../../../doc/en_US.ISO8859-1/books/fdp-primer \
		../../../doc/en_US.ISO8859-1/books/porters-handbook \
		../../../doc/en_US.ISO8859-1/books/ppp-primer

all afterinstall: index.html
	(cd ${.CURDIR}/../../../doc/en_US.ISO8859-1/articles && ${MAKE} 'FORMATS=html html-split' 'DESTDIR=${DESTDIR}/data/tutorials/$${.CURDIR:T}' ${.TARGET:S/afterinstall/install/})
	(cd ${.CURDIR}/../../../doc/en_US.ISO8859-1/books/fdp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/docproj-primer ${.TARGET:S/afterinstall/install/})
	(cd ${.CURDIR}/../../../doc/en_US.ISO8859-1/books/porters-handbook && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/porters-handbook ${.TARGET:S/afterinstall/install/})
	(cd ${.CURDIR}/../../../doc/en_US.ISO8859-1/books/ppp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/ppp ${.TARGET:S/afterinstall/install/})

.include "${WEB_PREFIX}/share/mk/web.site.mk"
