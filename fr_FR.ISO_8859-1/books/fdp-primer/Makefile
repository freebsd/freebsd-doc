#
#    The FreeBSD Documentation Project
#    The FreeBSD French Documentation Project
#
#    Compilation de l'Introduction au Projet de Documentation de FreeBSD
#
#    $FreeBSD$
#    Original revision: 1.6
# 

MAINTAINER=nik@FreeBSD.ORG

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml 
SRCS+= overview/chapter.sgml 
SRCS+= psgml-mode/chapter.sgml 
SRCS+= see-also/chapter.sgml 
SRCS+= sgml-markup/chapter.sgml 
SRCS+= sgml-primer/chapter.sgml 
SRCS+= stylesheets/chapter.sgml 
SRCS+= the-faq/chapter.sgml 
SRCS+= the-handbook/chapter.sgml 
SRCS+= the-website/chapter.sgml 
SRCS+= tools/chapter.sgml 
SRCS+= translations/chapter.sgml
SRCS+= writing-style/chapter.sgml 

# Entities
SRCS+= chapters.ent 
SRCS+= ../handbook/mailing-lists.ent
SRCS+= ../../../en_US.ISO_8859-1/books/handbook/authors.ent

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
