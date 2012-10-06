#
#    The FreeBSD Documentation Project
#    The FreeBSD French Documentation Project
#
#    Compilation de la FAQ FreeBSD
#
#    $FreeBSD$
#    Original revision: 1.7
MAINTAINER=doc@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+=-Vbiblio-xref-title
#
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
SRCS=  book.xml

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
