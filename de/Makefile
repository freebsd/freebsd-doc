# The FreeBSD Documentation Project
# The FreeBSD German Documentation Project
# $FreeBSD$
# $FreeBSDde: de-www/Makefile,v 1.8 2002/12/06 21:56:35 ue Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif


# These are turned into validated, normalized HTML files.

DOCS+= availability.sgml
DOCS+= index.sgml

CLEANFILES+=atoz.sgml site.sgml

# These will be directly installed.

#DATA=	robots.txt index.html

# Subdirectories
# SGML
SUBDIR=  FAQ
SUBDIR+= handbook
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
.endif

# These *must* be listed after the "doc" subdir, as they create symlinks
# in to it.
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
#SUBDIR+= tutorials
.endif

SGMLFLAGS+=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr

WEBDIR=		data/de

.include "${WEB_PREFIX}/share/mk/web.site.mk"
