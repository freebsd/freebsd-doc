#
# Build the Handbook with just the content from this chapter.
#
# $FreeBSD$
# $Id: Makefile,v 1.2 2003-05-08 10:07:51 blackend Exp $
# Original revision: 1.2
#

CHAPTERS= 	pgpkeys/chapter.xml

PGPKEYS!=	perl -ne 'm/\"([\w-]+.key)\"/ && print "$$1\n"' \
		${DOC_PREFIX}/share/pgpkeys/pgpkeys.ent
SRCS+=		${PGPKEYS}

VPATH=		..

MASTERDOC=	${.CURDIR}/../${DOC}.${DOCBOOKSUFFIX}

DOC_PREFIX?= 	${.CURDIR}/../../../..

.include "../Makefile"
