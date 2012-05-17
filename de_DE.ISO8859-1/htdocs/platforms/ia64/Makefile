# $FreeBSD$
# $FreeBSDde: de-www/platforms/ia64/Makefile,v 1.5 2006/10/19 19:26:04 jkois Exp $
# basiert auf: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	machines.sgml refs.sgml
#DATA=	i2inside.png mckinley-die.png merced-die.png montecito-die.png

XMLDOCS=        index::news.xml:
XMLDOCS+=       todo::news.xml:

.include "${WEB_PREFIX}/share/mk/web.site.mk"
