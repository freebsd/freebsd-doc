# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=		docs
SUBDIR+=	images
SUBDIR+=	patches

DOCS=	screenshots.sgml
DOCS+=	contact.sgml

DATA=	index.html newsflash.html

CLEANFILES=	index.html
CLEANFILES+=	newsflash.html
CLEANFILES+=	gnotices.rdf

GNOTICES_RDF_URL=	http://news.gnome.org/gnome-news/rdf

index.html: index.xsl news.xml includes.xsl ../includes.xsl gnotices.rdf
	${XSLTPROC} ${XSLTPROCOPTS} -o index.html \
		${.CURDIR}/index.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} index.html
.endif

newsflash.html: newsflash.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/newsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

gnotices.rdf::
	fetch -qo - ${GNOTICES_RDF_URL} | ${SED} 's|rdf:RDF|rdf| ; \
		s|xmlns.*[^>]||' > ${.TARGET}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
