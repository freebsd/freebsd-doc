# The FreeBSD Documentation Project
# The FreeBSD German Documentation Project
# $FreeBSD$
# $FreeBSDde: de-www/Makefile,v 1.15 2003/08/14 23:13:43 mheinen Exp $
# basiert auf: 1.98

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml
DOCS+= availability.sgml
DOCS+= features.sgml
DOCS+= internet.sgml
DOCS+= mailto.sgml
DOCS+= relnotes.sgml
DOCS+= where.sgml

# These will be directly installed.

#DATA=	favicon.ico
#DATA+=	robots.txt
#DATA+=	freebsd.css
#DATA+=	vendors.html

# Subdirectories
# SGML
SUBDIR= news
SUBDIR+= FAQ
SUBDIR+= handbook
SUBDIR+= releases
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
#SUBDIR+= ports
SUBDIR+= doc
.endif
.if defined(BUILD_RELNOTES)
SUBDIR+= relnotes
.endif

# These *must* be listed after the "doc" subdir, as they create symlinks
# in to it.
#.if !defined(WEB_ONLY) || empty(WEB_ONLY)
#SUBDIR+= tutorials
#.endif

# Non-SGML
SUBDIR+= gifs
#SUBDIR+= cgi

COOKIE=	FAQ handbook

WEBDIR?=	data/de

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

#index.html: index.xsl news/news.xml news/press.xml includes.xsl news/includes.xsl security/advisories.xml
index.html: index.xsl news/news.xml includes.xsl news/includes.xsl security/advisories.xml
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/index.xsl ${.CURDIR}/news/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

WEBCHECK?=	${PREFIX}/bin/webcheck
WEBCHECKOPTS?=	-ab ${WEBCHECKFLAGS}
WEBCHECKDIR?=	/webcheck
WEBCHECKINSTALLDIR?= ${DESTDIR}${WEBCHECKDIR}
WEBCHECKURL?=	http://www.FreeBSD.org/

webcheck:
	@[ -d ${WEBCHECKINSTALLDIR} ] || ${MKDIR} ${WEBCHECKINSTALLDIR}
	${WEBCHECK} ${WEBCHECKOPTS} -o ${WEBCHECKINSTALLDIR} ${WEBCHECKURL}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
