# $FreeBSD: www/ja/Makefile,v 1.64 2004/01/22 14:42:28 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.106

.if exists(../Makefile.conf)
.include "../Makefile.conf"
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
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml 
DOCS+= y2kbug.sgml 

# Japanese-only file
DOCS+= jabout.sgml

# These will be directly installed.

#DATA=	favicon.ico
#DATA+=	robots.txt
DATA+=	freebsd.css
#DATA+=  vendors.html

# Subdirectories
# SGML
SUBDIR=	 security
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
SUBDIR+= prstats
SUBDIR+= platforms
SUBDIR+= releases
#SUBDIR+= releng
SUBDIR+= smp
#SUBDIR+= kse
#SUBDIR+= gnome
#SUBDIR+= donations
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
SUBDIR+= doc
# .endif
# .if defined(BUILD_RELNOTES)
# SUBDIR+= relnotes
.endif

# These *must* be listed after the "doc" subdir, as they create symlinks
# in to it.
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= tutorials
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

WEBDIR?=	data/ja

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

index.html: index.xsl ${XML_INCLUDES}\
		${XML_NEWS_INCLUDES} ${XML_NEWS_NEWS} ${XML_NEWS_PRESS}\
		${XML_MIRRORS} ${XML_ADVISORIES}
	${XSLTPROC} ${XSLTPROCOPTS} \
		-o $@ \
		--param mirrors.xml "'${XML_MIRRORS}'" \
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param news.press.xml "'${XML_NEWS_PRESS}'" \
		--param news.project.xml "'${XML_NEWS_NEWS}'" \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif
