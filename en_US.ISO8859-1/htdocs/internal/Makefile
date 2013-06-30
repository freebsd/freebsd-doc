# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS= 	about.xml
DOCS+=	bylaws.xml
DOCS+=	clusteradm.xml
DOCS+=	core-vote.xml
DOCS+= 	data.xml
DOCS+= 	developer.xml
DOCS+=	doceng.xml
DOCS+=	expire-bits.xml
DOCS+=	fortunes.xml
DOCS+=	hats.xml
DOCS+=	i18n.xml
DOCS+=	internal.xml
DOCS+= 	machines.xml
DOCS+= 	mirror.xml
DOCS+=	new-account.xml
DOCS+=	policies.xml
DOCS+=	proposing-committers.xml
DOCS+=  releng.xml
DOCS+=  resources.xml
DOCS+=	statistic.xml
DOCS+=	working-with-hats.xml

INDEXLINK=	internal.html

# build the list of personal homepages of FreeBSD developers only
# on the main FreeBSD machines
hostname!= hostname
.if !empty(hostname:M*.freebsd.org)
DOCS+=	homepage.xml

.if !make(install)
.PHONY: homepage.inc
.endif
homepage.inc: homepage.pl
	${PERL} ${.CURDIR}/homepage.pl > ${.TARGET}

homepage.html:  homepage.inc
CLEANFILES+=	homepage.inc
.endif

DATA+=	README.mirror ssh-keys.asc

.include "${DOC_PREFIX}/share/mk/web.site.mk"
