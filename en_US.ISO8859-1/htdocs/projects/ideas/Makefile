# FreeBSD list of projects and ideas for volunteers
#
# $FreeBSD: www/en/projects/ideas/Makefile,v 1.1 2005/12/06 15:09:29 joel Exp $

MAINTAINER=	joel

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=	style.css

XML_IDEAS=		${DOC_PREFIX}/en_US.ISO8859-1/htdocs/projects/ideas/ideas.xml
XSL_IDEAS=		${DOC_PREFIX}/en_US.ISO8859-1/htdocs/projects/ideas/ideas.xsl

XMLDOCS=	ideas:${XSL_IDEAS}:${XML_IDEAS}:

INDEXLINK=	ideas.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"
