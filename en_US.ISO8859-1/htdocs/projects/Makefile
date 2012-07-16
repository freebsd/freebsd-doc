# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.sgml
DOCS+=	newbies.sgml
DOCS+=	cvsweb.sgml
DOCS+=	summerofcode.sgml
DOCS+=	summerofcode-2005.sgml
DOCS+=	summerofcode-2006.sgml
DOCS+=	summerofcode-2007.sgml
DOCS+=	summerofcode-2008.sgml

DATA=	2009-freebsd-gsoc-thumbnail.jpg
DATA+=	2009-freebsd-gsoc.pdf
DATA+=	2010-freebsd-gsoc-thumbnail.jpg
DATA+=	2010-freebsd-gsoc.pdf
#DATA+=	2011-freebsd-gsoc-thumbnail.jpg
DATA+=	2011-freebsd-gsoc.pdf

INDEXLINK= projects.html

SUBDIR=	 acpi busdma c99 ideas mips bigdisk netperf

.include "${DOC_PREFIX}/share/mk/web.site.mk"
