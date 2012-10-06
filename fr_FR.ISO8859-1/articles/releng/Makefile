#
#    The FreeBSD Documentation Project
#    The FreeBSD French Documentation Project
#
# $FreeBSD$
# $Id: Makefile,v 1.1 2002-08-30 11:58:25 gioria Exp $
# Original revision: 1.7
#
# Article: FreeBSD Release Engineering

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+=	-V %generate-article-toc%

# XML content
SRCS=  article.xml branches.ascii

# IMAGES
IMAGES= branches.pic

CSS_SHEET_ADDITIONS= extra.css

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
