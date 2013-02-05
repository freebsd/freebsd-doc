#
# $FreeBSD$
#

MAINTAINER=grog@FreeBSD.org

DOC?= article

FORMATS?= html

WITH_ARTICLE_TOC?=YES

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# SRCS incluye todos y cada uno de los ficheros XML que conforman el
# documento. Cualquier cambio en cualquiera de ellos implica volver a
# generar el documento.
#

# XML content
SRCS=  article.xml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"
