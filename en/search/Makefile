# $Id: Makefile,v 1.3 1998-08-11 01:18:41 wosch Exp $

.if exists("../Makefile.conf")
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
	sort -fu web.atoz | perl atoz.pl > ${.TARGET}

site.sgml: site.map
	./site.pl < ${.ALLSRC} > ${.TARGET}

.include "../web.mk"

