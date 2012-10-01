#
# Build the Handbook with just the content from this chapter.
#
# $FreeBSD$
#
# Build the FreeBSD Handbook (Brazilian Portuguese).
#
# The FreeBSD Documentation Project
# The FreeBSD Brazilian Portuguese Documentation Project
#
# Original revision: 1.1
#

CHAPTERS= 	pgpkeys/chapter.xml

PGPKEYS!=	perl -ne 'm/\"([\w-]+.key)\"/ && print "$$1\n"' \
		    ${DOC_PREFIX}/share/pgpkeys/pgpkeys.ent
SRCS+=		${PGPKEYS}

VPATH=		..

MASTERDOC=	${.CURDIR}/../${DOC}.${DOCBOOKSUFFIX}

DOC_PREFIX?= 	${.CURDIR}/../../../..

.include "../Makefile"
