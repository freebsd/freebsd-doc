#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/Makefile,v 1.22 2003/09/30 17:31:32 andy Exp $
#
# Original revision: 1.98
#

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
#DOCS+= relnotes.sgml
#DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml
DOCS+= y2kbug.sgml

# Subdirectories
# SGML
SUBDIR=  security
SUBDIR+= commercial
SUBDIR+= docproj
SUBDIR+= news
#SUBDIR+= advocacy

#SUBDIR+= events
SUBDIR+= FAQ
SUBDIR+= handbook
SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= projects
#SUBDIR+= prstats
SUBDIR+= platforms
SUBDIR+= releases
#SUBDIR+= releng
SUBDIR+= smp
#SUBDIR+= kse
#SUBDIR+= gnome
SUBDIR+= donations
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
#SUBDIR+= doc
.endif
.if defined(BUILD_RELNOTES)
SUBDIR+= relnotes
.endif

# These *must* be listed after the "doc" subdir, as they create symlinks
# in to it.
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= tutorials
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

COOKIE=		FAQ handbook

SGMLOPTS+=	-e KOI8-R
FORMATS=	"html ps koi8-r"

WEBDIR?=	data/ru

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

index.html: index.xsl news/news.xml news/press.xml includes.xsl news/includes.xsl security/advisories.xml
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/index.xsl ${.CURDIR}/news/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

WEBCHECK?=     ${PREFIX}/bin/webcheck
WEBCHECKOPTS?= -ab ${WEBCHECKFLAGS}
WEBCHECKDIR?=  /webcheck
WEBCHECKINSTALLDIR?= ${DESTDIR}${WEBCHECKDIR}
WEBCHECKURL?=  http://www.FreeBSD.org/

webcheck:
	@[ -d ${WEBCHECKINSTALLDIR} ] || ${MKDIR} ${WEBCHECKINSTALLDIR}
	${WEBCHECK} ${WEBCHECKOPTS} -o ${WEBCHECKINSTALLDIR} ${WEBCHECKURL}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
