#
# $FreeBSD$
#
# This is an XML version of the pmake tutorial by Adam de Boor that is
# also part of the src/share/doc/psd collection of docs.
#

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# SRCS lists the individual XML files that make up the document.
# Changes to any of these files will force a rebuild.

# XML content
SRCS=	book.xml
SRCS+=	answers/chapter.xml
SRCS+=	basics/chapter.xml
SRCS+=	glossary/glossary.xml
SRCS+=	gods/chapter.xml
SRCS+=	intro/chapter.xml
SRCS+=	shortcuts/chapter.xml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"
