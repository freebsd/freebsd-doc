# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/internal/Makefile,v 1.3 2000/11/10 17:04:50 phantom Exp $
# Original version: 1.23

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
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

homepage.inc: ${GENHOMEPAGE}
	${PERL} $(GENHOMEPAGE) > ${.TARGET}

homepage.sgml:  $(GENHOMEPAGE) homepage.inc
CLEANFILES+=	homepage.inc
.endif

DATA+=	README.mirror

.include "${WEB_PREFIX}/share/mk/web.site.mk"
