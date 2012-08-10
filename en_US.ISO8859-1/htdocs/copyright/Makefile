# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	copyright.sgml
DOCS+=	daemon.sgml
DOCS+=	freebsd-doc-license.sgml
DOCS+=	freebsd-license.sgml
DOCS+=	license.sgml
DOCS+=	trademarks.sgml

INDEXLINK= copyright.html

DATA+= COPYING COPYING.LIB LEGAL

CLEANFILES+= LEGAL

LEGAL:
	${FETCH} http://svn.freebsd.org/ports/head/LEGAL

.include "${DOC_PREFIX}/share/mk/web.site.mk"
