# $FreeBSD: www/en/gallery/Makefile,v 1.13 2001/09/05 07:51:40 kuriyama Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XSLTPROCFLAGS=	--catalogs
XSLT=	${SETENV} SGML_CATALOG_FILES=${PREFIX}/share/xml/dtd/xhtml/xhtml.soc \
	${XSLTPROC} ${XSLTPROCFLAGS}

INDEXLINK= gallery.html

DATA+=	gallery.html cgallery.html npgallery.html pgallery.html

CLEANFILES+= ${DATA}

gallery.html: gallery.xml gallery.xsl ../includes.xsl
	${XSLT} ${.CURDIR}/gallery.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
	-${TIDY} ${TIDYFLAGS} ${.TARGET}

cgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'commercial\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
	-${TIDY} ${TIDYFLAGS} ${.TARGET}

npgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'nonprofit\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
	-${TIDY} ${TIDYFLAGS} ${.TARGET}

pgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'personal\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
	-${TIDY} ${TIDYFLAGS} ${.TARGET}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
