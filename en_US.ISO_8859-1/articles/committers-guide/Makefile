# 
# $Id: Makefile,v 1.2 1999-09-05 22:14:26 nik Exp $
#
# Build the FreeBSD New Committers Guide
#

MAINTAINER=jhb@FreeBSD.org

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  article.sgml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"
