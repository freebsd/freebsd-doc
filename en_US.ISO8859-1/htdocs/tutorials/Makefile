#
# $FreeBSD: www/en/tutorials/Makefile,v 1.11 2001/06/11 02:39:04 ache Exp $
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS = index.sgml

.include "${WEB_PREFIX}/share/mk/web.site.mk"
