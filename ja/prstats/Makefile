# $FreeBSD: www/en/prstats/Makefile,v 1.4 2001/12/06 12:33:06 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	index.sgml

### Revision checking
REVCHECK=	yes

.if defined(WITH_PRSTATS)
SUBDIR+= ../../tools/prstats
.else
beforeinstall:
	${PERL} -pi -e 's/SRC=\"gnats/SRC=\"http:\/\/www.FreeBSD.org\/prstats\/gnats/' index.html
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
