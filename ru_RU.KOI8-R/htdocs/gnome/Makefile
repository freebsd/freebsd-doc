# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/gnome/Makefile,v 1.2 2003/10/25 15:33:19 andy Exp $
#
# Original revision: 1.13

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=		docs
#SUBDIR+=	images

DOCS=	screenshots.xml
DOCS+=	contact.xml

DATA=	index.html newsflash.html news.rdf

CLEANFILES=	index.html
CLEANFILES+=	newsflash.html
CLEANFILES+=	news.rdf

index.html! index.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS:N-nonet} -o index.html \
		${.CURDIR}/index.xsl ${.CURDIR}/news.xml
.endif

news.rdf: rss.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o news.rdf \
		${.CURDIR}/rss.xsl ${.CURDIR}/news.xml
.endif

newsflash.html: newsflash.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/newsflash.xsl ${.CURDIR}/news.xml
.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"
