# $FreeBSD: www/ja/search/Makefile,v 1.8 2000/04/24 02:16:33 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.7

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

index-site.html: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	sort -fu ${.ALLSRC} | ${PERL} ${.CURDIR}/../../en/search/atoz.pl > ${.TARGET}
site.sgml: ${.CURDIR}/../../en/search/site.map
	${PERL} ${.CURDIR}/../../en/search/site.pl < ${.ALLSRC} > ${.TARGET}

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	search

.include "../../web.mk"
