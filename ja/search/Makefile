# $FreeBSD: www/ja/search/Makefile,v 1.6 1999/09/07 15:15:59 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.5

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

# These are turned into validated, normalized HTML files.

DOCS+= index-site.sgml
DOCS+= search.sgml 
DOCS+= searchhints.sgml
DOCS+= search-mid.sgml

INDEXLINK=      search.html
CLEANFILES+=atoz.sgml site.sgml

index-site.sgml: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	sort -fu web.atoz | perl ../../en/search/atoz.pl > ${.TARGET}
site.sgml: ../../en/search/site.map
	perl ../../en/search/site.pl < ${.ALLSRC} > ${.TARGET}

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	search

.include "../../web.mk"
