# $FreeBSD: www/en/gnome/Makefile,v 1.9 2002/02/11 16:54:52 sobomax Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=		docs
SUBDIR+=	images
SUBDIR+=	patches

DOCS=	screenshots.sgml
DOCS+=	contact.sgml

DATA=	index.html newsflash.html

CLEANFILES=	index.html
CLEANFILES+=	newsflash.html

index.html! index.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS:N-nonet} -o index.html \
		${.CURDIR}/index.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} index.html
.endif

newsflash.html: newsflash.xsl news.xml includes.xsl ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/newsflash.xsl ${.CURDIR}/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
