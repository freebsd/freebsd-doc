# $FreeBSD: www/ja/Makefile,v 1.47 2001/08/08 02:08:09 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.58

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
SUBDIR+= alpha

SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
#SUBDIR+= gallery
SUBDIR+= projects
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
# SUBDIR+= tutorials
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
# Extern
SUBDIR+= tutorials

DOCSUBDIR=	FAQ handbook
.endif
SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr -e EUC-JP

WEBDIR=		data/ja

index.html: index.xsl news/news.xml includes.xsl news/includes.xsl
	xsltproc -nonet -o index.html index.xsl news/news.xml
#	-tidy -i -m -f /dev/null index.html

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"
