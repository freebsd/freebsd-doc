# $Id: Makefile,v 1.6 1999-05-03 14:36:15 kuriyama Exp $

LINKS= 	en/ja en/es en/ru en/zh en/tutorials ja/web.mk ja/FAQ en/FAQ
LINKS+=	web.mk es/FAQ ru/FAQ zh/FAQ ../doc/en/web.mk
LINKS+= ../doc/en/includes.sgml

SUBDIR= en

all: links


links: ${LINKS}

clean:
	rm -f ${LINKS}


en/ja:
	cd en; ln -sf ../ja

en/es:
	cd en; ln -sf ../es

en/ru:
	cd en; ln -sf ../ru

en/zh:
	cd en; ln -sf ../zh

en/tutorials:
	cd en; ln -sf ../../doc/en/tutorials

en/FAQ:
	cd en; ln -sf ../../doc/FAQ

ja/web.mk:
	cd ja; ln -sf ../en/web.mk

ja/FAQ:
	cd ja; ln -sf ../../doc/ja/FAQ

web.mk:
	cd .;  ln -sf en/web.mk

es/FAQ:
	cd es; ln -sf ../../doc/es/FAQ

ru/FAQ:
	cd ru; ln -sf ../../doc/ru/FAQ

zh/FAQ:
	cd zh; ln -sf ../../doc/zh/FAQ

../doc/en/web.mk:
	cd ../doc/en; ln -sf ../../www/en/web.mk

../doc/en/includes.sgml:
	cd ../doc/en; ln -sf ../../www/en/includes.sgml

.include <bsd.subdir.mk>
