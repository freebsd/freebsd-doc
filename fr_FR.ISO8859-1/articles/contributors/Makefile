#
# The FreeBSD Documentation Project
# The FreeBSD French Documentation Project
#
# $FreeBSD$
# $Id: Makefile,v 1.1 2002-08-24 15:40:21 gioria Exp $
# Original revision: 1.1

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+=	-V %generate-article-toc%

SRCS= article.xml

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
