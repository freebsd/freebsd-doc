# $FreeBSD$

.if exists(../../Makefile.conf)
.include "../../Makefile.conf"
.endif
.if exists(../../Makefile.inc)
.include "../../Makefile.inc"
.endif

WEB_PREFIX?= ${.CURDIR}/../..
PRGRAPHDIR?= ${DESTDIR}${WEBBASE}/ports/growth
GNUPLOT?= /usr/local/bin/gnuplot
PNGTOPNM?= /usr/local/bin/pngtopnm
PNMTOPNG?= /usr/local/bin/pnmtopng

IMG= status.png
CLEANFILES=	${IMG}

INSTALL_WEB?=   \
	${INSTALL} ${COPY} ${INSTALLFLAGS} -o ${WEBOWN} -g ${WEBGRP} -m ${WEBMODE}

all:	${IMG}

update:
	sh getinfo.sh

status.png:	ports.plt ports.log
	${GNUPLOT} ports.plt
	${PNGTOPNM} ports.png | ${PNMTOPNG} -i > ${IMG}
	rm ports.png

install:	${IMG}
.if exists(${.CURDIR}/${IMG})
	${INSTALL_WEB} ${.CURDIR}/${IMG} ${PRGRAPHDIR}
.else
	${INSTALL_WEB} ${IMG} ${PRGRAPHDIR}
.endif

.include "${WEB_PREFIX}/../share/mk/web.site.mk"
