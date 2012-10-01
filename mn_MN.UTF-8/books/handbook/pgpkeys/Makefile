# $FreeBSD$
#
# The FreeBSD Mongolian Documentation Project
#
# Original revision 1.3
#
# Build the Handbook with just the content from this chapter.
#

CHAPTERS= 	pgpkeys/chapter.xml

PGPKEYS!=	perl -ne 'm/\"([\w-]+.key)\"/ && print "$$1\n"' \
		    ${DOC_PREFIX}/share/pgpkeys/pgpkeys.ent
SRCS+=		${PGPKEYS}

VPATH=		..

MASTERDOC=	${.CURDIR}/../${DOC}.${DOCBOOKSUFFIX}

DOC_PREFIX?= 	${.CURDIR}/../../../..

.include "../Makefile"
