# $FreeBSD: www/ja/gallery/Makefile,v 1.15 2001/09/17 03:07:39 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.14

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XSLTPROCFLAGS=	--catalogs
XSLT=	${SETENV} SGML_CATALOG_FILES=${PREFIX}/share/xml/dtd/xhtml/xhtml.soc \
	${XSLTPROC} ${XSLTPROCFLAGS}

SRC=	../../en/gallery/gallery.xml

INDEXLINK= gallery.html

DATA+=	gallery.html cgallery.html npgallery.html pgallery.html

CLEANFILES+= ${DATA}

gallery.html: ${SRC} gallery.xsl ../includes.xsl
	${XSLT} ${.CURDIR}/gallery.xsl ${.CURDIR}/${SRC} > ${.TARGET}
#	-${TIDY} ${TIDYFLAGS} ${.TARGET}

cgallery.html: ${SRC} gallery-entry.xsl
	${XSLT} --param type \'commercial\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/${SRC} > ${.TARGET}
#	-${TIDY} ${TIDYFLAGS} ${.TARGET}

npgallery.html: ${SRC} gallery-entry.xsl
	${XSLT} --param type \'nonprofit\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/${SRC} > ${.TARGET}
#	-${TIDY} ${TIDYFLAGS} ${.TARGET}

pgallery.html: ${SRC} gallery-entry.xsl
	${XSLT} --param type \'personal\' \
		${.CURDIR}/gallery-entry.xsl ${.CURDIR}/${SRC} > ${.TARGET}
#	-${TIDY} ${TIDYFLAGS} ${.TARGET}

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"
