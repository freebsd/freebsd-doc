# $FreeBSD: www/de/news/Makefile,v 1.3 2004/05/15 12:39:08 brueffer Exp $
# $FreeBSDde: de-www/news/Makefile,v 1.6 2004/05/02 00:21:16 brueffer Exp $
# basiert auf: 1.39

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

.include "${WEB_PREFIX}/share/mk/web.site.mk"

newsflash.html: newsflash.xsl news.xml\
			includes.xsl ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param "news.project.xml-master" "'${XML_NEWS_NEWS_MASTER}'" \
		--param "news.project.xml" "'${XML_NEWS_NEWS}'" \
		--param "transtable.xml" "'${XML_TRANSTABLE}'" \
		${.CURDIR}/newsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

news.rdf: news-rdf.xsl news.xml\
		includes.xsl ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/news-rdf.xsl ${.CURDIR}/news.xml

press.html: press.xsl press.xml\
		includes.xsl ${XML_INCLUDES}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param "news.press.xml-master" "'${XML_NEWS_PRESS_MASTER}'" \
		--param "news.press.xml" "'${XML_NEWS_PRESS}'" \
		--param "transtable.xml" "'${XML_TRANSTABLE}'" \
		${.CURDIR}/press.xsl ${.CURDIR}/press.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif
