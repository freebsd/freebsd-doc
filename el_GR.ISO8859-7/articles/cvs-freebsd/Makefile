# $FreeBSD$
# Original version: 1.4
#
# Στήνοντας ένα CVS repository με τα εργαλεία του FreeBSD.

MAINTAINER= keramida@freebsd.org

DOC?= article

FORMATS?= html

TIDY_FLAGS+= -raw

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS=	article.sgml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"
