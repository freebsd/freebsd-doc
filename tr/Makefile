# The FreeBSD Documentation Project
# The FreeBSD Turkish Documentation Project
# $FreeBSD: www/tr/Makefile,v 1.1 2003/12/01 21:26:21 blackend Exp $
# Original revision: 1.98
.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS= docs.sgml
DOCS+= features.sgml
DOCS+= mailto.sgml

# These will be directly installed.

#DATA=	favicon.ico
#DATA+=	robots.txt
#DATA+=	freebsd.css
#DATA+=  vendors.html

# Subdirectories
# SGML
#SUBDIR= security
#SUBDIR+= commercial
#SUBDIR+= docproj
#SUBDIR+= news
#SUBDIR+= advocacy

#SUBDIR+= events
#SUBDIR+= FAQ
#SUBDIR+= handbook
#SUBDIR+= internal
#SUBDIR+= java
#SUBDIR+= copyright
#SUBDIR+= search
#SUBDIR+= gallery
#SUBDIR+= projects
#SUBDIR+= prstats
#SUBDIR+= platforms
#SUBDIR+= releases
#SUBDIR+= releng
#SUBDIR+= smp
#SUBDIR+= kse
#SUBDIR+= gnome
#SUBDIR+= donations
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR= doc
.endif


# These *must* be listed after the "doc" subdir, as they create symlinks
# in to it.
#.if !defined(WEB_ONLY) || empty(WEB_ONLY)
#SUBDIR+= tutorials
#.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi



# Non-English

WEBDIR=	data/tr

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

index.html: index.xsl ../en/news/news.xml ../en/news/press.xml includes.xsl ../en/news/includes.xsl ../share/sgml/advisories.xml
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/index.xsl ${.CURDIR}/../en/news/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif


.include "${WEB_PREFIX}/share/mk/web.site.mk"
