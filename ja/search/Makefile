# $FreeBSD: www/ja/search/Makefile,v 1.7 1999/12/23 01:16:11 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.6

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
	sort -fu web.atoz | ${PERL} ../../en/search/atoz.pl > ${.TARGET}
site.sgml: ../../en/search/site.map
	${PERL} ../../en/search/site.pl < ${.ALLSRC} > ${.TARGET}

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	search

.include "../../web.mk"
