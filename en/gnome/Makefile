# $FreeBSD: www/en/gnome/Makefile,v 1.19 2004/11/10 13:57:24 ceri Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=		docs
SUBDIR+=	images

DOCS=	screenshots.sgml
DOCS+=	contact.sgml

DATA=	index.html newsflash.html news.rdf gnome_upgrade.sh gnomelogalyzer.sh

CLEANFILES=	index.html
CLEANFILES+=	newsflash.html
CLEANFILES+=	news.rdf

index.html! index.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS:N-nonet} -o index.html \
		${.CURDIR}/index.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} index.html
.endif

news.rdf: rss.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o news.rdf \
		${.CURDIR}/rss.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} -xml -wrap 0 ${TIDYOPTS} news.rdf
.endif

newsflash.html: newsflash.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/newsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
