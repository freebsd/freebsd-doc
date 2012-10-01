#
# Build the Handbook with just the content from this chapter.
#
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/handbook/pgpkeys/Makefile,v 1.3 2003/11/08 00:20:47 phantom Exp $
# Original revision: r16831
#

CHAPTERS= 	pgpkeys/chapter.xml

PGPKEYS!=	perl -ne 'm/\"([\w-]+.key)\"/ && print "$$1\n"' \
		    ${DOC_PREFIX}/share/pgpkeys/pgpkeys.ent
SRCS+=		${PGPKEYS}

VPATH=		..

MASTERDOC=	${.CURDIR}/../${DOC}.${DOCBOOKSUFFIX}

DOC_PREFIX?= 	${.CURDIR}/../../../..

.include "../Makefile"
