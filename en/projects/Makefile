# $FreeBSD: www/en/projects/Makefile,v 1.31 2007/04/13 02:02:54 murray Exp $

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

XML_IDEAS=		${WEB_PREFIX}/en/projects/ideas/ideas.xml
XSL_SOC=		${WEB_PREFIX}/en/projects/summerofcode.xsl

XMLDOCS=	summerofcode:${XSL_SOC}:${XML_IDEAS}:

INDEXLINK= projects.html

SUBDIR=	 acpi busdma c99 ideas mips bigdisk netperf

.include "${WEB_PREFIX}/share/mk/web.site.mk"
