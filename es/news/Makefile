# $FreeBSD: www/es/news/Makefile,v 1.5 1999/09/06 07:03:03 peter Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# quick news letter
DOCS=	qnewsletter.sgml
DOCS+=	qnewsletter-1-1.sgml
DOCS+=	qnewsletter-1-2.sgml
DOCS+=	qnewsletter-1-3.sgml
DOCS+=	qnewsletter-1-4.sgml
DOCS+=	qnewsletter-1-5.sgml
DOCS+=	qnewsletter-1-6.sgml
DOCS+=	qnewsletter-1-7.sgml
DOCS+=	qnewsletter-2-1.sgml
DOCS+=	qnewsletter-2-2.sgml

DOCS+= press.sgml
DOCS+= newsflash.sgml
DOCS+= news.sgml
DOCS+= webchanges.sgml

# press releases
DOCS+= pressreleases.sgml
DOCS+= press-rel-1.sgml
DOCS+= press-rel-2.sgml
DOCS+= press-rel-3.sgml

INDEXLINK= news.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
