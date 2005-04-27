#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/news/2003/Makefile,v 1.1 2005/04/27 17:55:52 andy Exp $
#
# Original revision: 1.1
#

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=		index.html press.html
CLEANFILES+=	index.html press.html

index.html: ../oldnewsflash.xsl news.xml \
		${XML_INCLUDES} ${XML_TRANSTABLE}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/../oldnewsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

press.html: ../oldpress.xsl press.xml \
		${XML_INCLUDES} ${XML_TRANSTABLE}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/../oldpress.xsl ${.CURDIR}/press.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
