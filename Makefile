# $Id: Makefile,v 1.2 1998-12-30 17:53:56 wosch Exp $

LINKS= 	en/ja en/es en/ru en/tutorials ja/web.mk ja/FAQ en/FAQ en/handbook
LINKS+=	ja/handbook web.mk es/FAQ ru/FAQ ../doc/en/web.mk
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

en/tutorials:
	cd en; ln -sf ../../doc/en/tutorials

en/FAQ:
	cd en; ln -sf ../../doc/FAQ

en/handbook:
	cd en; ln -sf ../../doc/handbook

ja/web.mk:
	cd ja; ln -sf ../en/web.mk

ja/FAQ:
	cd ja; ln -sf ../../doc/ja/FAQ

ja/handbook:
	cd ja; ln -sf ../../doc/ja/handbook

web.mk:
	cd .;  ln -sf en/web.mk

es/FAQ:
	cd es; ln -sf ../../doc/es/FAQ

ru/FAQ:
	cd ru; ln -sf ../../doc/ru/FAQ

../doc/en/web.mk:
	cd ../doc/en; ln -sf ../../www/en/web.mk

../doc/en/includes.sgml:
	cd ../doc/en; ln -sf ../../www/en/includes.sgml

.include <bsd.subdir.mk>
