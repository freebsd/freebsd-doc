#
# $FreeBSD: www/tools/prstats/Makefile,v 1.2 2001/11/18 16:11:34 murray Exp $
#

.if exists(../../en/Makefile.conf)
.include "../../en/Makefile.conf"
.endif
.if exists(../../en/Makefile.inc)
.include "../../en/Makefile.inc"
.endif

WEB_PREFIX?= ${.CURDIR}/../..
GNATSDIR?= /c/gnats
PRGRAPHDIR?= ${DESTDIR}${WEBBASE}/prstats
GNUPLOT?= /usr/local/bin/gnuplot

GRAPHS= gnats.png
GRAPHS+= gnats1.png gnats1r.png
GRAPHS+= gnats30.png gnats30r.png
GRAPHS+= gnats365.png gnats365r.png
GRAPHS+= gnats7.png gnats7r.png
CLEANFILES= ${GRAPHS}
CLEANFILES+= _ __ __1 __30 __365 __7

INSTALL_WEB?=	\
	${INSTALL} ${COPY} ${INSTALLFLAGS} -o ${WEBOWN} -g ${WEBGRP} -m ${WEBMODE}

all:
	./go.tcl ${GNATSDIR}
	./eval.tcl
	./cut.tcl 365 __ __365
	./cut.tcl 30 __ __30
	./cut.tcl 7 __ __7
	./cut.tcl 1 __ __1
	${GNUPLOT} g

install: ${GRAPHS}
.for entry in ${GRAPHS}
.if exists(${.CURDIR}/${entry})
	${INSTALL_WEB} ${.CURDIR}/${entry} ${PRGRAPHDIR}
.else
	${INSTALL_WEB} ${entry} ${PRGRAPHDIR}
.endif
.endfor

.include "${WEB_PREFIX}/share/mk/web.site.mk"
