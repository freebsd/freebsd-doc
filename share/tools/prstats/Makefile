#
# $FreeBSD$
#

.if exists(../../../en_US.ISO8859-1/Makefile.conf)
.include "../../../en_US.ISO8859-1/Makefile.conf"
.endif
.if exists(../../../en_US.ISO8859-1/Makefile.inc)
.include "../../../en_US.ISO8859-1/Makefile.inc"
.endif

DOC_PREFIX?= ${.CURDIR}/../../..
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

.include "${DOC_PREFIX}/share/mk/web.site.mk"
