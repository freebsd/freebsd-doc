#
# Build the Handbook with just the content from this chapter.
#
# $FreeBSD$
# $Id: Makefile,v 1.1 2002-08-30 17:52:00 blackend Exp $
# Original revision: 1.2
#

CHAPTERS= 	pgpkeys/chapter.sgml

PGPKEYS!=	perl -ne 'm/\"([\w-]+.key)\"/ && print "$$1\n"' \
		${DOC_PREFIX}/en_US.ISO8859-1/books/handbook/pgpkeys/pgpkeys.ent
SRCS+=		${PGPKEYS}

VPATH=		..

MASTERDOC=	${.CURDIR}/../${DOC}.${DOCBOOKSUFFIX}

DOC_PREFIX?= 	${.CURDIR}/../../../..

.include "../Makefile"
