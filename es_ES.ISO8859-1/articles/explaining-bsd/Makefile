# 
# $FreeBSD$
#

MAINTAINER=grog@FreeBSD.org

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# SRCS incluye todos y cada uno de los ficheros SGML que conforman el 
# documento. Cualquier cambio en cualquiera de ellos implica volver a 
# generar el documento.  
#

# SGML content
SRCS=  article.sgml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"
