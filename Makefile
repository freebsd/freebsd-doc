# $FreeBSD: www/Makefile,v 1.14 2000/09/30 00:21:38 nbm Exp $

WEB_PREFIX=	${.CURDIR}

LINKS=	en/ja en/es en/ru en/zh
LINKS+=	ja/web.mk es/web.mk ru/web.mk
LINKS+=	web.mk

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
LINKS+= ../doc/en_US.ISO_8859-1/web.mk
LINKS+= ../doc/en_US.ISO_8859-1/includes.sgml
.endif

SUBDIR= en

.if make(obj)
SUBDIR+= ja es ru zh
.endif

all: links


links: ${LINKS}

clean:
	rm -f ${LINKS}


en/ja:
	cd en; ln -sf ${.CURDIR}/ja

en/es:
	cd en; ln -sf ${.CURDIR}/es

en/ru:
	cd en; ln -sf ${.CURDIR}/ru

en/zh:
	cd en; ln -sf ${.CURDIR}/zh

ja/web.mk:
	cd ja; ln -sf ${.CURDIR}/en/web.mk

es/web.mk:
	cd es; ln -sf ${.CURDIR}/en/web.mk

ru/web.mk:
	cd ru; ln -sf ${.CURDIR}/en/web.mk

web.mk:
	cd .;  ln -sf ${.CURDIR}/en/web.mk

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
../doc/en_US.ISO_8859-1/web.mk:
	cd ../doc/en_US.ISO_8859-1; ln -sf ${.CURDIR}/en/web.mk

../doc/en_US.ISO_8859-1/includes.sgml:
	cd ../doc/en_US.ISO_8859-1; ln -sf ${.CURDIR}/en/includes.sgml
.endif

.include <bsd.obj.mk>
.include <bsd.subdir.mk>
