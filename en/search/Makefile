# $FreeBSD: www/en/search/Makefile,v 1.6 2000/04/20 16:41:32 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
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

.include "../web.mk"

