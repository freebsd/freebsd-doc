# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.xml todo.xml schedule.xml approvals.xml

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

.include "${DOC_PREFIX}/share/mk/web.site.mk"
