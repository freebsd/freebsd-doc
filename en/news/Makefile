# $FreeBSD: www/en/news/Makefile,v 1.22 2000/10/21 16:39:25 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= press.sgml
DOCS+= newsflash.sgml
DOCS+= news.sgml
#DOCS+= webchanges.sgml

# press releases
DOCS+= pressreleases.sgml
DOCS+= press-rel-1.sgml
DOCS+= press-rel-2.sgml
DOCS+= press-rel-3.sgml
DOCS+= press-rel-4.sgml
DOCS+= press-rel-5.sgml

# The yearly State of the Union address
DOCS+= sou1999.sgml

INDEXLINK= news.html

SUBDIR= 	1996
SUBDIR+= 	1997

.include "${WEB_PREFIX}/share/mk/web.site.mk"
