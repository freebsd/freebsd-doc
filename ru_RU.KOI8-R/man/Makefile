# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/man/Makefile,v 1.8 2007/11/21 15:56:48 ru Exp $

BINDIR=	${SHAREDIR}/man/ru_RU.KOI8-R

SUBDIR=	man1 man3 man5 man8

distrib-dirs:
	mkdir -p ${DESTDIR}${BINDIR}
	mtree -deU -f ${.CURDIR}/FRDP.man.dist -p ${DESTDIR}${BINDIR}

makedb:
	makewhatis ${DESTDIR}${BINDIR}

beforeinstall: distrib-dirs
afterinstall: makedb

.include <bsd.subdir.mk>
