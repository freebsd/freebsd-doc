# $FreeBSD: www/ja/news/Makefile,v 1.19 2000/06/15 01:40:22 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.20

.if exists(../Makefile.conf)
.include "../Makefile.conf"
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
#DOCS+= webchanges.sgml

# press releases
DOCS+= pressreleases.sgml
DOCS+= press-rel-1.sgml
DOCS+= press-rel-2.sgml
DOCS+= press-rel-3.sgml
DOCS+= press-rel-4.sgml

# The yearly State of the Union address
#DOCS+=	sou1999.sgml

INDEXLINK= news.html

SUBDIR= 	1996
SUBDIR+= 	1997

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	news

.include "../web.mk"
