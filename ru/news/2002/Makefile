#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/news/2002/Makefile,v 1.4 2004/04/09 11:16:52 phantom Exp $
#
# Original revision: 1.3

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=		index.html press.html
CLEANFILES+=	index.html press.html

index.html: ../oldnewsflash.xsl news.xml\
			../includes.xsl ../../includes.xsl ${XML_TRANSTABLE}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/../oldnewsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

press.html: ../oldpress.xsl press.xml \
		../includes.xsl ../../includes.xsl ${XML_TRANSTABLE}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/../oldpress.xsl ${.CURDIR}/press.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
