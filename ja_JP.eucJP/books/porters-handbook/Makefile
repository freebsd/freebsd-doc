# 
# $FreeBSD$
#
# Build the FreeBSD Porter's Handbook.
#
# Original revision: 1.1

MAINTAINER=kuriyama@FreeBSD.org

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

# Use the local DSSSL file
DSLHTML?= 	${.CURDIR}/freebsd.dsl
DSLPRINT?= 	${.CURDIR}/freebsd.dsl

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"
