#
#    The FreeBSD Documentation Project
#    The FreeBSD French Documentation Project
#
#    Compilation du Manuel du Developpeur de FreeBSD
#
#
# 
#    $FreeBSD$
#    Original revision: 1.25
#
# 

MAINTAINER=gioria@FreeBSD.org

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml

# Entities

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
