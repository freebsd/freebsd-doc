# $FreeBSD: www/en/Makefile,v 1.82 2002/04/04 21:51:28 trhodes Exp $
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
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml 
DOCS+= y2kbug.sgml 

# These will be directly installed.

DATA=	favicon.ico
DATA+=	robots.txt
DATA+=	freebsd.css

# Subdirectories
# SGML
SUBDIR=	 security
SUBDIR+= commercial
SUBDIR+= docproj
SUBDIR+= news
SUBDIR+= advocacy

SUBDIR+= events
SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= projects
SUBDIR+= prstats
SUBDIR+= platforms
SUBDIR+= releases
SUBDIR+= releng
SUBDIR+= smp
SUBDIR+= conspectus
SUBDIR+= gnome
SUBDIR+= donations
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
SUBDIR+= doc
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
SUBDIR+= gifs
SUBDIR+= cgi

WEB_LANG?=	ja es ru zh de

COOKIE=	FAQ handbook

# Non-English

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.for DIR in ${WEB_LANG}
SUBDIR+=	../${DIR}
.endfor
.endif

WEBDIR=		data

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

index.html: index.xsl news/news.xml news/press.xml includes.xsl news/includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o index.html \
		${.CURDIR}/index.xsl ${.CURDIR}/news/news.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} index.html
.endif

# Handle the FAQ/ and handbook/ directories specially.
FAQ:
	${LN} -fs ${.OBJDIR}/../../doc/en_US.ISO8859-1/books/faq FAQ

handbook:
	${LN} -fs ${.OBJDIR}/../../doc/en_US.ISO8859-1/books/handbook handbook

# In "make obj" case FAQ and handbook are symlinks and have to be removed
# at "make clean"
.if ${.OBJDIR} != ${.CURDIR}
CLEANFILES+=	FAQ
CLEANFILES+=	handbook
.endif

afterinstall:
	cd ${DOCINSTALLDIR}; \
		${LN} -fs doc/en_US.ISO8859-1/books/faq ${DOCINSTALLDIR}/FAQ
	cd ${DOCINSTALLDIR}; \
		${LN} -fs doc/en_US.ISO8859-1/books/handbook ${DOCINSTALLDIR}/handbook

LINBOT?=	${PREFIX}/bin/linbot
LINBOTOPTS?=	-ab
LINBOTDIR?=	/linbot
LINBOTINSTALLDIR?= ${DESTDIR}${LINBOTDIR}
LINBOTURL?=	http://www.FreeBSD.org/

linbot:
	@[ -d ${LINBOTINSTALLDIR} ] || ${MKDIR} ${LINBOTINSTALLDIR}
	${LINBOT} ${LINBOTOPTS} -o ${LINBOTINSTALLDIR} ${LINBOTURL}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
