# $FreeBSD: www/en/internal/Makefile,v 1.21 2000/03/12 21:44:02 phantom Exp $

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

INDEXLINK=	internal.html

# build the list of personal homepages of FreeBSD developers only 
# on the main FreeBSD machines
hostname!= hostname
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org"
DOCS+=	homepage.sgml
.PHONY: homepage.inc

homepage.inc: homepage.pl
	${PERL} homepage.pl > ${.TARGET}

homepage.sgml:  homepage.inc
CLEANFILES+=	homepage.inc
.endif

DATA+=	README.mirror

.include "../web.mk"
