# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.4

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
