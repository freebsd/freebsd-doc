# $FreeBSD: www/ru/Makefile,v 1.9 2000/02/28 12:58:25 phantom Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif


# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml
DOCS+= auditors.sgml
DOCS+= availability.sgml
DOCS+= docs.sgml
DOCS+= features.sgml
DOCS+= register.sgml
DOCS+= index.sgml
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
SUBDIR+= docproj
#SUBDIR+= news
SUBDIR+= alpha
SUBDIR+= internal
SUBDIR+= copyright
#SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= projects
#SUBDIR+= releases
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
# Extern
SUBDIR+= tutorials

#DOCSUBDIR=	FAQ handbook
DOCSUBDIR=	FAQ
.endif

SGMLOPTS+=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr
SGMLOPTS+=	-e KOI8-R
FORMATS=	"html ps koi8-r"

WEBDIR?=	data/ru

.include "web.mk"

