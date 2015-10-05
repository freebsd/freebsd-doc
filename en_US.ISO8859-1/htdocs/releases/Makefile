# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?=	index.xml

SUBDIR= 	1.0 1.1 1.1.5 2.0 2.0.5R 2.1R 2.1.5R 2.1.6R 2.1.7R 2.2R
SUBDIR+=	2.2.1R 2.2.2R 2.2.5R 2.2.6R 2.2.7R 2.2.8R 3.0R 3.1R 3.2R
SUBDIR+=	3.3R 3.4R 3.5R 4.0R 4.1R 4.1.1R 4.2R 4.3R 4.4R 4.5R 4.6R
SUBDIR+=	4.6.2R 4.7R 4.8R 4.9R 4.10R 4.11R
SUBDIR+=	5.0R 5.1R 5.2R 5.2.1R 5.3R 5.4R 5.5R
SUBDIR+=	6.0R 6.1R 6.2R 6.3R 6.4R
SUBDIR+=	7.0R 7.1R 7.2R 7.3R 7.4R
SUBDIR+=	8.0R 8.1R 8.2R 8.3R 8.4R
SUBDIR+=	9.0R 9.1R 9.2R 9.3R
SUBDIR+=	10.0R 10.1R 10.2R 10.3R
SUBDIR+=	11.0R

.if defined(NEW_BUILD)
SUBDIR=
.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"
