# $FreeBSD$
# $FreeBSDde: de-www/news/Makefile,v 1.4 2003/09/27 12:05:17 mheinen Exp $
# basiert auf: 1.38

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml

INDEXLINK= news.html

SUBDIR= 	2002

DATA=		newsflash.html news.rdf press.html
CLEANFILES+=	newsflash.html news.rdf press.html

newsflash.html: newsflash.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/newsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

news.rdf: news-rdf.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/news-rdf.xsl ${.CURDIR}/news.xml

press.html: press.xsl press.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/press.xsl ${.CURDIR}/press.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
