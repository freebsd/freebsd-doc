#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/articles/pxe/Makefile,v 1.3 2003/12/28 07:21:55 andy Exp $
#
# Original revision: 1.4
#

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

SRCS= article.sgml

DOC_PREFIX?= ${.CURDIR}/../../..

afterinstall:
	${INSTALL_DOCS} \
	    ${DOC_PREFIX}/en_US.ISO8859-1/articles/pxe/dhcpd.conf \
	    ${DOC_PREFIX}/en_US.ISO8859-1/articles/pxe/install.cfg \
	    ${DOC_PREFIX}/en_US.ISO8859-1/articles/pxe/loader.rc \
            ${DOC_PREFIX}/en_US.ISO8859-1/articles/pxe/pkgmaker.sh \
	    ${DOC_PREFIX}/en_US.ISO8859-1/articles/pxe/post \
            ${DOC_PREFIX}/en_US.ISO8859-1/articles/pxe/pre ${DESTDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
