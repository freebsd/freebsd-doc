# $FreeBSD: www/en/projects/Makefile,v 1.33 2009/03/16 13:43:53 rwatson Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.sgml
DOCS+=	newbies.sgml
DOCS+=	cvsweb.sgml
DOCS+=	summerofcode-2005.sgml
DOCS+=	summerofcode-2006.sgml
DOCS+=	summerofcode-2007.sgml
DOCS+=	summerofcode-2008.sgml

DATA=	2009-freebsd-gsoc-thumbnail.jpg
DATA+=	2009-freebsd-gsoc.pdf
DATA+=	2010-freebsd-gsoc-thumbnail.jpg
DATA+=	2010-freebsd-gsoc.pdf

XML_IDEAS=		${WEB_PREFIX}/en/projects/ideas/ideas.xml
XSL_SOC=		${WEB_PREFIX}/en/projects/summerofcode.xsl

XMLDOCS=	summerofcode:${XSL_SOC}:${XML_IDEAS}:

INDEXLINK= projects.html

SUBDIR=	 acpi busdma c99 ideas mips bigdisk netperf

.include "${WEB_PREFIX}/share/mk/web.site.mk"
