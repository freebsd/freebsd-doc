# $FreeBSD: www/en/internal/Makefile,v 1.16 1999/09/15 20:34:35 wosch Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=	photos.sgml	
DOCS+=	internal.sgml	
DOCS+= 	about.sgml
DOCS+= 	machines.sgml
DOCS+= 	mirror.sgml
DOCS+=	statistic.sgml
DOCS+= 	developer.sgml

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
LOCAL=  committers-guide.html
.endif

committers-guide.html: ../../../doc/en_US.ISO_8859-1/articles/committers-guide/article.sgml
	(cd ../../../doc/en_US.ISO_8859-1/articles/committers-guide && ${MAKE} FORMATS=html INSTALL_COMPRESSED='')
	cp ../../../doc/en_US.ISO_8859-1/articles/committers-guide/article.html committers-guide.html

INDEXLINK=	internal.html

# build the list of personal homepages of FreeBSD developers only 
# on the main FreeBSD machines
hostname!= hostname
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org"
DOCS+=	homepage.sgml
.PHONY: homepage.inc

homepage.inc:
	perl homepage.pl > ${.TARGET}

homepage.sgml:  homepage.inc
CLEANFILES+=	homepage.inc
.endif

DATA+=	README.mirror

.include "../web.mk"
