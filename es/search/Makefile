# $FreeBSD: www/es/search/Makefile,v 1.2 1999/09/06 07:03:13 peter Exp $

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
