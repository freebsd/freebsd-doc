# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.38

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	photos.xml
DOCS+=	internal.xml
DOCS+= 	about.xml
DOCS+= 	machines.xml
DOCS+= 	mirror.xml
DOCS+=	new-account.xml
DOCS+=	statistic.xml
DOCS+= 	developer.xml
DOCS+=	bylaws.xml
DOCS+=  releng.xml
DOCS+=	expire-bits.xml
DOCS+=	core-vote.xml
# DOCS+=	trb-dispute.xml
# DOCS+=	doceng.xml
# DOCS+=	rtp.xml

INDEXLINK=	internal.html

# build the list of personal homepages of FreeBSD developers only
# on the main FreeBSD machines
hostname!= hostname
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org" || ${hostname} == "www.freebsd.org"
DOCS+=	homepage.xml
.PHONY: homepage.inc

homepage.inc: ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/internal/homepage.pl
	${PERL} ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/internal/homepage.pl > ${.TARGET}

homepage.html:  homepage.inc
CLEANFILES+=	homepage.inc
.endif

# DATA+=	README.mirror ssh-keys.asc

.include "${DOC_PREFIX}/share/mk/web.site.mk"
