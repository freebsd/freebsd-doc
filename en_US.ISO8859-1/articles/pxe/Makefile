# $FreeBSD$

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

SRCS= article.sgml

DOC_PREFIX?= ${.CURDIR}/../../..

afterinstall:
	${INSTALL_DOCS} ${.CURDIR}/dhcpd.conf ${.CURDIR}/install.cfg \
	    ${.CURDIR}/loader.rc ${.CURDIR}/pkgmaker.sh \
	    ${.CURDIR}/post ${.CURDIR}/pre ${DESTDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
