# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	schedule.sgml

#FETCHFILE= http://people.freebsd.org/~pho/stress/log/news.rss
#FETCHCMD=  /usr/bin/fetch
#CLEANFILES+= news.rss stress.html

#DATA+=	docbook.css

#news.rss:
#	${FETCHCMD} ${FETCHFILE}

#stress.html: news.rss stress.xsl
#	${XSLTPROC} stress.xsl news.rss > stress.html

#todo.html: stress.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
