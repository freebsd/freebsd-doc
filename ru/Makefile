# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/Makefile,v 1.12 2001/12/17 19:55:35 phantom Exp $
# Original revision: 1.55

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml
DOCS+= auditors.sgml
DOCS+= availability.sgml
DOCS+= docs.sgml
DOCS+= features.sgml
DOCS+= register.sgml
DOCS+= internet.sgml
DOCS+= mailto.sgml
DOCS+= publish.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml
DOCS+= y2kbug.sgml

CLEANFILES+=atoz.sgml site.sgml

# These will be directly installed.

#DATA=	COPYING COPYING.LIB README.mirror robots.txt index.html
DATA=	index.html

# Subdirectories
# SGML
SUBDIR=  security
SUBDIR+= commercial
SUBDIR+= conspectus
SUBDIR+= docproj
SUBDIR+= news
SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= projects
SUBDIR+= releases
SUBDIR+= smp
SUBDIR+= platforms
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
# Extern
SUBDIR+= tutorials
SUBDIR+= handbook

#DOCSUBDIR=	FAQ handbook
DOCSUBDIR=	FAQ
.endif

SGMLOPTS+=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr
SGMLOPTS+=	-e KOI8-R
FORMATS=	"html ps koi8-r"

WEBDIR?=	data/ru

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html

index.html: index.xsl news/news.xml news/press.xml includes.xsl news/includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o index.html \
		${.CURDIR}/index.xsl ${.CURDIR}/news/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"
