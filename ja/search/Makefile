# $FreeBSD: www/ja/search/Makefile,v 1.12 2001/11/17 17:21:09 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.9

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
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
	${SORT} -fu ${.ALLSRC} | ${PERL} ${.CURDIR}/../../en/search/atoz.pl > ${.TARGET}

site.sgml: site.map
	${PERL} ${.CURDIR}/../../en/search/site.pl < ${.ALLSRC} > ${.TARGET}

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"
