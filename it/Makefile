# $FreeBSD: www/it/Makefile,v 1.1 2003/03/20 00:10:51 trhodes Exp $
.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  docs.sgml 
DOCS+= mailto.sgml 

# Subdirectories
# SGML
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR=  doc
.endif

WEBDIR?=	data/it

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

index.html: index.xsl includes.xsl ../en/news/includes.xsl ../en/news/news.xml ../en/news/press.xml ../en/security/advisories.xml
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/index.xsl ${.CURDIR}/../en/news/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
