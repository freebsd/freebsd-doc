# $FreeBSD: www/en/prstats/Makefile,v 1.2 2001/11/18 16:13:07 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	index.sgml

.if !defined(NO_PRSTATS)
SUBDIR+= ../../tools/prstats
.else
beforeinstall:
	${PERL} -pi -e 's/SRC=\"gnats/SRC=\"http:\/\/www.FreeBSD.org\/prstats\/gnats/' index.html
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
