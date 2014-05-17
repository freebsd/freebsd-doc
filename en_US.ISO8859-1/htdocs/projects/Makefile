# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.xml
DOCS+=	newbies.xml
DOCS+=	cvsweb.xml
DOCS+=	summerofcode.xml
DOCS+=	summerofcode-2005.xml
DOCS+=	summerofcode-2006.xml
DOCS+=	summerofcode-2007.xml
DOCS+=	summerofcode-2008.xml

DATA=	2014-freebsd-gsoc-thumbnail.jpg
DATA+=	2014-freebsd-gsoc.pdf

INDEXLINK= projects.html

SUBDIR=	 acpi busdma ideas mips netperf

.include "${DOC_PREFIX}/share/mk/web.site.mk"
