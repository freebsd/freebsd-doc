# $FreeBSD: www/en/prstats/Makefile,v 1.3 2001/11/19 04:47:58 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	index.sgml

.if defined(WITH_PRSTATS)
SUBDIR+= ../../tools/prstats
.else
beforeinstall:
	${PERL} -pi -e 's/SRC=\"gnats/SRC=\"http:\/\/www.FreeBSD.org\/prstats\/gnats/' index.html
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
