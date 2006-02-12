# $FreeBSD: www/en/releases/6.1R/Makefile,v 1.1 2006/01/25 23:58:36 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	todo.sgml approvals.sgml
DOCS+=	schedule.sgml

FETCHFILE= http://people.freebsd.org/~pho/stress/log/news.rdf
FETCHCMD=  /usr/bin/fetch
CLEANFILES+= news.rdf stress.html

news.rdf:
	${FETCHCMD} ${FETCHFILE}

stress.html: news.rdf stress.xsl
	${XSLTPROC} stress.xsl news.rdf > stress.html

todo.html: stress.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
