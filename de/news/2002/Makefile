# $FreeBSD$
# $FreeBSDde: de-www/news/2002/Makefile,v 1.1 2003/08/02 18:17:29 mheinen Exp $
# basiert auf: 1.1

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=		index.html
CLEANFILES+=	index.html

index.html: ../oldnewsflash.xsl news.xml ../includes.xsl ../../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/../oldnewsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
