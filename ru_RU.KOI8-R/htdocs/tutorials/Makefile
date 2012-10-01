#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/tutorials/Makefile,v 1.5 2004/01/06 11:12:26 andy Exp $
#
# Original revision: 1.12
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS = index.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"
