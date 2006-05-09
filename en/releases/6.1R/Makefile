# $FreeBSD: www/en/releases/6.1R/Makefile,v 1.2 2006/02/12 15:36:17 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	todo.sgml schedule.sgml approvals.sgml
DOCS+=	announce.sgml

FETCHFILE= http://people.freebsd.org/~pho/stress/log/news.rdf
FETCHCMD=  /usr/bin/fetch
CLEANFILES+= news.rdf stress.html

news.rdf:
	${FETCHCMD} ${FETCHFILE}

stress.html: news.rdf stress.xsl
	${XSLTPROC} stress.xsl news.rdf > stress.html

todo.html: stress.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
