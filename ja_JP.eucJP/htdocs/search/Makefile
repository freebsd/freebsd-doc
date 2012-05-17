# $FreeBSD$
# The FreeBSD Japanese Documentation Project
# Original revision: 1.10

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

#SUBDIR+= opensearch

INDEXLINK=      search.html
CLEANFILES+=atoz.sgml site.sgml

index-site.html: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	${SORT} -fu ${.ALLSRC} | ${PERL} ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/search/atoz.pl > ${.TARGET}

site.sgml: site.map
	${PERL} ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/search/site.pl < ${.ALLSRC} > ${.TARGET}

### Revision checking
REVCHECK=	YES

.include "${DOC_PREFIX}/share/mk/web.site.mk"
