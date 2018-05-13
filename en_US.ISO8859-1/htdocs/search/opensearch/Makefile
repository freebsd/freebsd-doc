# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= 		opensearch.xml
INDEXLINK=	opensearch.html

DATA=
DATA+=	opensearch.js

DATA+=	man.xml
DATA+=	man-freebsd-release-ports.xml
DATA+=	message-id.xml

# external sites
DATA+=	markmail.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"
