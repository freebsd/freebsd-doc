# $FreeBSD: www/en/internal/Makefile,v 1.38 2003/11/24 23:30:29 trhodes Exp $

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
DOCS+=	new-account.sgml
DOCS+=	statistic.sgml
DOCS+= 	developer.sgml
DOCS+=	bylaws.sgml
DOCS+=  releng.sgml
DOCS+=	expire-bits.sgml
DOCS+=	core-vote.sgml
DOCS+=	trb-dispute.sgml
DOCS+=	doceng.sgml
DOCS+=	rtp.sgml
DOCS+=	policies.sgml

INDEXLINK=	internal.html

# build the list of personal homepages of FreeBSD developers only 
# on the main FreeBSD machines
hostname!= hostname
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org" || ${hostname} == "www.freebsd.org"
DOCS+=	homepage.sgml
.PHONY: homepage.inc

homepage.inc: homepage.pl
	${PERL} ${.CURDIR}/homepage.pl > ${.TARGET}

homepage.html:  homepage.inc
CLEANFILES+=	homepage.inc
.endif

DATA+=	README.mirror ssh-keys.asc

.include "${WEB_PREFIX}/share/mk/web.site.mk"
