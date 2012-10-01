#
# $FreeBSD$
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

# The FreeBSD French Documentation Project
# Original revision: 1.12

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS = index.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"
