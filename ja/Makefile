# $FreeBSD: www/ja/Makefile,v 1.52 2001/10/30 15:09:52 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.75

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
#DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml 
DOCS+= y2kbug.sgml 

# Japanese-only file
DOCS+= jabout.sgml

# These will be directly installed.

#DATA=	favicon.ico
#DATA+=	robots.txt

# Subdirectories
# SGML
SUBDIR=	 security
SUBDIR+= commercial
SUBDIR+= docproj
SUBDIR+= news

SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= projects
#SUBDIR+= prstats
SUBDIR+= platforms
SUBDIR+= releases
SUBDIR+= smp
SUBDIR+= conspectus
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
# SUBDIR+= doc
# .endif
# .if defined(BUILD_RELNOTES)
# SUBDIR+= relnotes
# .endif
#
# # These *must* be listed after the "doc" subdir, as they create symlinks
# # in to it.
# .if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= tutorials

DOCSUBDIR=	FAQ handbook
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr -e EUC-JP

WEBDIR=		data/ja

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

index.html: index.xsl news/news.xml news/press.xml includes.xsl news/includes.xsl
	${XSLTPROC} ${XSLTPROCFLAGS} -o index.html \
		${.CURDIR}/index.xsl ${.CURDIR}/news/news.xml
#	-${TIDY} ${TIDYFLAGS} index.html

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"
