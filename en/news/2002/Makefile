# $FreeBSD: www/en/news/2002/Makefile,v 1.1 2003/07/11 19:51:56 ceri Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=		index.html
CLEANFILES+=	index.html

index.html: ../oldnewsflash.xsl news.xml\
			../includes.xsl ../../includes.xsl ${XML_TRANSTABLE}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/../oldnewsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
