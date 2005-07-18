# $FreeBSD: www/en/releases/6.0R/Makefile,v 1.3 2005/06/11 18:46:30 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	todo.sgml schedule.sgml approvals.sgml
FETCHFILE= http://people.freebsd.org/~pho/stress/log/news.rdf
FETCHCMD=  /usr/bin/fetch
CLEANFILES+= news.rdf stress.html

DATA=	docbook.css

news.rdf:
	${FETCHCMD} ${FETCHFILE}

stress.html: news.rdf stress.xsl
	${XSLTPROC} stress.xsl news.rdf > stress.html

todo.html: stress.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
