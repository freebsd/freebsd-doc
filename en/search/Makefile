# $FreeBSD: www/en/search/Makefile,v 1.7 2000/09/30 00:21:39 nbm Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= index-site.sgml
DOCS+= search.sgml 
DOCS+= searchhints.sgml
DOCS+=	search-mid.sgml

INDEXLINK=	search.html
CLEANFILES+=atoz.sgml site.sgml


index-site.html: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	sort -fu ${.ALLSRC} | ${PERL} ${.CURDIR}/atoz.pl > ${.TARGET}

site.sgml: site.map
	${PERL} ${.CURDIR}/site.pl < ${.ALLSRC} > ${.TARGET}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
