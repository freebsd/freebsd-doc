#
# Build the Handbook with just the content from this chapter.
#
# %SOURCE%    en_US.ISO8859-1/books/handbook/pgpkeys/Makefile
# %SRCID%     1.3
#
# $FreeBSD$
#

CHAPTERS= 	pgpkeys/chapter.xml

PGPKEYS!=	perl -ne 'm/\"([\w-]+.key)\"/ && print "$$1\n"' \
		    ${DOC_PREFIX}/share/pgpkeys/pgpkeys.ent
SRCS+=		${PGPKEYS}

VPATH=		..

MASTERDOC=	${.CURDIR}/../${DOC}.${DOCBOOKSUFFIX}

DOC_PREFIX?= 	${.CURDIR}/../../../..

.include "../Makefile"
