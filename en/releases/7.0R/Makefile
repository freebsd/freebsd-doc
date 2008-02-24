# $FreeBSD: www/en/releases/7.0R/Makefile,v 1.2 2007/09/10 12:26:48 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	todo.sgml schedule.sgml approvals.sgml

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
