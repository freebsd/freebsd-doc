# $FreeBSD: www/en/releases/7.0R/Makefile,v 1.3 2008/02/24 05:55:04 bmah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml todo.sgml schedule.sgml approvals.sgml

FETCHFILE= http://people.freebsd.org/~pho/stress/log/news.rss
FETCHCMD=  /usr/bin/fetch
CLEANFILES+= news.rss stress.html

DATA+=	docbook.css
DATA+=	errata.html
DATA+=	hardware.html
DATA+=	readme.html
DATA+=	relnotes.html

news.rss:
	${FETCHCMD} ${FETCHFILE}

stress.html: news.rss stress.xsl
	${XSLTPROC} stress.xsl news.rss > stress.html

todo.html: stress.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
