# $FreeBSD: www/en/Makefile,v 1.63 2001/04/17 12:18:20 nik Exp $
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
SUBDIR+= doc
.endif

# These *must* be listed after the "doc" subdir, as they create symlinks
# in to it.
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= tutorials
.endif

# Non-SGML
SUBDIR+= gifs
SUBDIR+= cgi

WEB_LANG?=	ja es ru zh de

COOKIE=	FAQ handbook

# Non-English

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.for DIR in ${WEB_LANG}
#SUBDIR+=	../${DIR}
.endfor
.endif

SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr

WEBDIR=		data

# Handle the FAQ/ and handbook/ directories specially.

FAQ:
	ln -fs ${.CURDIR}/../../doc/en_US.ISO_8859-1/books/faq FAQ

handbook:
	ln -fs ${.CURDIR}/../../doc/en_US.ISO_8859-1/books/handbook handbook

afterinstall:
	ln -fs ${.CURDIR}/doc/en_US.ISO_8859-1/books/faq ${DOCINSTALLDIR}/FAQ
	ln -fs ${.CURDIR}/doc/en_US.ISO_8859-1/books/handbook ${DOCINSTALLDIR}/handbook

.include "${WEB_PREFIX}/share/mk/web.site.mk"
