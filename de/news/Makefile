# $FreeBSD$
# $FreeBSDde: de-www/news/Makefile,v 1.3 2003/08/03 16:46:32 mheinen Exp $
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

DATA=		newsflash.html news.rdf
CLEANFILES+=	newsflash.html news.rdf

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
