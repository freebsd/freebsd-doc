#
#    The FreeBSD Documentation Project
#    The FreeBSD French Documentation Project
#
#    Compilation de l'Introduction au Projet de Documentation de FreeBSD
#
#    $FreeBSD$
#    Original revision: 1.6
#

MAINTAINER=doc@FreeBSD.ORG

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

#
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
SRCS=  book.xml
SRCS+= overview/chapter.xml
SRCS+= psgml-mode/chapter.xml
SRCS+= see-also/chapter.xml
SRCS+= sgml-markup/chapter.xml
SRCS+= sgml-primer/chapter.xml
SRCS+= stylesheets/chapter.xml
SRCS+= the-faq/chapter.xml
SRCS+= the-handbook/chapter.xml
SRCS+= the-website/chapter.xml
SRCS+= tools/chapter.xml
SRCS+= translations/chapter.xml
SRCS+= writing-style/chapter.xml

# Entities
SRCS+= chapters.ent

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
