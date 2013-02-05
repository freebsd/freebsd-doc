#
# $FreeBSD$
#
# Μορφοποίηση του FreeBSD FAQ
#
# %SOURCE%	en_US.ISO8859-1/books/faq/Makefile
# %SRCID%	1.12
#

MAINTAINER=doc@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

WITH_BIBLIOXREF_TITLE?=YES

#
# Η λίστα SRCS περιέχει όλα τα XML αρχεία που αποτελούν μέρη του κειμένου.
# Αλλαγές σε οποιοδήποτε από αυτά τα αρχεία προκαλούν rebuild.
#

# XML content
SRCS=  book.xml

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
