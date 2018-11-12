# $FreeBSD$

DOC_PREFIX?= ${.CURDIR}/../../..
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
	-mkdir -p ${PRGRAPHDIR}
.if exists(${.CURDIR}/${IMG})
	${INSTALL_WEB} ${.CURDIR}/${IMG} ${PRGRAPHDIR}
.else
	${INSTALL_WEB} ${IMG} ${PRGRAPHDIR}
.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"
