# $FreeBSD$
# $FreeBSDru: frdp/www/ru/internal/Makefile,v 1.2 2000/10/27 11:26:10 phantom Exp $
# Original version: 1.20

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

SCRIPTDIR= ../../en/internal
GENHOMEPAGE= $(SCRIPTDIR)/homepage.pl

homepage.inc:
	perl $(GENHOMEPAGE) > ${.TARGET}

homepage.sgml:  $(GENHOMEPAGE) homepage.inc
CLEANFILES+=	homepage.inc
.endif

DATA+=	README.mirror

.include "../web.mk"
