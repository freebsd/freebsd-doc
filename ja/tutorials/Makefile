#
# $FreeBSD: www/ja/tutorials/Makefile,v 1.7 2000/10/02 09:16:24 kuriyama Exp $
#
# Original revision: 1.10
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

DIRS_TO_CLEAN =	../../../doc/ja_JP.eucJP/articles \
		../../../doc/ja_JP.eucJP/books/porters-handbook \
		../../../doc/ja_JP.eucJP/books/ppp-primer
#		../../../doc/ja_JP.eucJP/books/fdp-primer \

all afterinstall:
	(cd ${.CURDIR}/../../../doc/ja_JP.eucJP/articles && ${MAKE} 'FORMATS=html html-split' 'DESTDIR=${DESTDIR}/data/ja/tutorials/$${.CURDIR:T}' ${.TARGET:S/afterinstall/install/})
#	(cd ${.CURDIR}/../../../doc/ja_JP.eucJP/books/fdp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/ja/tutorials/docproj-primer ${.TARGET:S/afterinstall/install/})
	(cd ${.CURDIR}/../../../doc/ja_JP.eucJP/books/porters-handbook && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/ja/porters-handbook ${.TARGET:S/afterinstall/install/})
	(cd ${.CURDIR}/../../../doc/ja_JP.eucJP/books/ppp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/ja/tutorials/ppp ${.TARGET:S/afterinstall/install/})

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
