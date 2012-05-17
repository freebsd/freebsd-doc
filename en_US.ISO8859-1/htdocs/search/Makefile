# $FreeBSD$

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

SUBDIR+= opensearch

INDEXLINK=	search.html
CLEANFILES+=atoz.sgml site.sgml


index-site.html: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	${SORT} -fu ${.ALLSRC} | ${PERL} ${.CURDIR}/atoz.pl > ${.TARGET}

site.sgml: site.map
	${PERL} ${.CURDIR}/site.pl < ${.ALLSRC} > ${.TARGET}

.include "${DOC_PREFIX}/share/mk/web.site.mk"
