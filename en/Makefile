# $FreeBSD: www/en/Makefile,v 1.61 2001/02/25 12:00:49 alex Exp $
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
DOCS+= index.sgml
DOCS+= internet.sgml 
DOCS+= mailto.sgml 
DOCS+= publish.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml 
DOCS+= y2kbug.sgml 

# These will be directly installed.

DATA=	robots.txt

# Subdirectories
# SGML
SUBDIR=	 security
SUBDIR+= commercial
SUBDIR+= doc
SUBDIR+= docproj
SUBDIR+= news
SUBDIR+= alpha
SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= projects
SUBDIR+= platforms
SUBDIR+= releases 
SUBDIR+= smp
SUBDIR+= conspectus
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
.endif

# These *must* be listed after the "doc" subdir, as they create symlinks
# in to it.
SUBDIR+= FAQ 
SUBDIR+= handbook
SUBDIR+= tutorials

# Non-SGML
SUBDIR+= gifs
SUBDIR+= cgi

WEB_LANG?=	ja es ru zh de

# Non-English

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.for DIR in ${WEB_LANG}
#SUBDIR+=	../${DIR}
.endfor
.endif

SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr

WEBDIR=		data

.include "${WEB_PREFIX}/share/mk/web.site.mk"
