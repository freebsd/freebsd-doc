# $FreeBSD: www/ja/search/Makefile,v 1.9 2000/09/30 12:30:40 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.7

LOCALTOP= ..

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
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
REVCHECK=	YES

.include "${LOCALTOP}/web.mk"
