# $FreeBSD: www/en/gallery/Makefile,v 1.14 2001/10/29 10:14:31 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XSLTPROCFLAGS=	--catalogs
XSLT=	${SETENV} SGML_CATALOG_FILES=${PREFIX}/share/xml/dtd/xhtml/xhtml.soc \
	${XSLTPROC} ${XSLTPROCOPTS}

INDEXLINK= gallery.html

DATA+=	gallery.html cgallery.html npgallery.html pgallery.html

CLEANFILES+= ${DATA}

gallery.html: gallery.xml gallery.xsl ../includes.xsl
	${XSLT} ${.CURDIR}/gallery.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
	-${TIDY} ${TIDYOPTS} ${.TARGET}

cgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'commercial\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
	-${TIDY} ${TIDYOPTS} ${.TARGET}

npgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'nonprofit\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
	-${TIDY} ${TIDYOPTS} ${.TARGET}

pgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'personal\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
	-${TIDY} ${TIDYOPTS} ${.TARGET}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
