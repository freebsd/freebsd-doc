# $FreeBSD: www/en/search/Makefile,v 1.5 1999/09/06 07:02:57 peter Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS+= index-site.sgml
DOCS+= search.sgml 
DOCS+= searchhints.sgml
DOCS+=	search-mid.sgml

INDEXLINK=	search.html
CLEANFILES+=atoz.sgml site.sgml


index-site.sgml: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	sort -fu web.atoz | ${PERL} atoz.pl > ${.TARGET}

site.sgml: site.map
	${PERL} site.pl < ${.ALLSRC} > ${.TARGET}

.include "../web.mk"

