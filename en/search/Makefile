# $Id: Makefile,v 1.2 1998-08-07 16:57:08 wosch Exp $

DOCS+= index-site.sgml
DOCS+= search.sgml 
DOCS+= searchhints.sgml
DOCS+=	search-mid.sgml

INDEXLINK=	search.html
CLEANFILES+=atoz.sgml site.sgml


index-site.sgml: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	sort -fu web.atoz | perl atoz.pl > ${.TARGET}

site.sgml: site.map
	./site.pl < ${.ALLSRC} > ${.TARGET}

.include "../web.mk"

