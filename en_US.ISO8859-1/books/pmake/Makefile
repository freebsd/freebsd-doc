#
# $FreeBSD$
#
# This is an SGML version of the pmake tutorial by Adam de Boor that is
# also part of the src/share/doc/psd collection of docs.
#

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# SRCS lists the individual SGML files that make up the document.
# Changes to any of these files will force a rebuild.

# SGML content
SRCS=	book.sgml
SRCS+=	answers/chapter.sgml
SRCS+=	basics/chapter.sgml
SRCS+=	glossary/glossary.sgml
SRCS+=	gods/chapter.sgml
SRCS+=	intro/chapter.sgml
SRCS+=	shortcuts/chapter.sgml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"
