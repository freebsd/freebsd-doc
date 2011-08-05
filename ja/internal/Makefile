# $FreeBSD: www/ja/internal/Makefile,v 1.22 2011/03/17 13:21:37 ryusuke Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.50

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+=  about.sgml
#DOCS+=	bylaws.sgml
#DOCS+=	core-vote.sgml
#DOCS+= 	data.sgml
DOCS+=	developer.sgml
#DOCS+=	doceng.sgml
#DOCS+=	expire-bits.sgml
#DOCS+=	fortunes.sgml
#DOCS+=	i18n.sgml
DOCS+=  internal.sgml   
DOCS+=  machines.sgml
DOCS+=  mirror.sgml
#DOCS+=	new-account.sgml
#DOCS+=	policies.sgml
#DOCS+=	releng.sgml
#DOCS+=  resources.sgml
DOCS+=	statistic.sgml

INDEXLINK=	internal.html

# build the list of personal homepages of FreeBSD developers only 
# on the main FreeBSD machines
#hostname!= hostname
#.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org" || ${hostname} == "www.freebsd.org"
#DOCS+=	homepage.sgml
#
#.if !make(install)
#.PHONY: homepage.inc
#.endif
#homepage.inc: homepage.pl
#	${PERL} ${.CURDIR}/homepage.pl > ${.TARGET}
#
#homepage.html:  homepage.inc
#CLEANFILES+=	homepage.inc
#.endif
#
#DATA+=	README.mirror ssh-keys.asc

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"
