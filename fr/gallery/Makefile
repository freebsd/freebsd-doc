# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.16

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
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

cgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'commercial\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

npgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'nonprofit\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

pgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'personal\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/gallery.xml > ${.TARGET}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
