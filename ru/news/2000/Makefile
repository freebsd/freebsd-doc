# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/news/2000/Makefile,v 1.3 2004/04/09 11:16:51 phantom Exp $
# Original revision: 1.3

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
 
DOCS=	index.sgml

DATA=		press.html
CLEANFILES+=	press.html

press.html: ../oldpress.xsl press.xml \
		../includes.xsl ../../includes.xsl ${XML_TRANSTABLE}
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/../oldpress.xsl ${.CURDIR}/press.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif


.include "${WEB_PREFIX}/share/mk/web.site.mk"
