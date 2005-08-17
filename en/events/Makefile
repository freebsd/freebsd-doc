# $FreeBSD: www/en/events/Makefile,v 1.7 2004/04/06 11:36:12 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=  2002
SUBDIR+= 2003

DATA=	events.css
DATA+=	events.html
DATA+=	events.ics

CLEANFILES+= events.html
CLEANFILES+= events.ics
CLEANFILES+= curdate.xml

INDEXLINK= events.html

DATE?=	/bin/date
TR?=	/usr/bin/tr
XMLLINT?= /usr/local/bin/xmllint # Part of textproc/libxml2.

events.html: events.xsl events.xml ../includes.xsl curdate.xml
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/events.xsl ${.CURDIR}/events.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

events.ics: events.xml
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${WEB_PREFIX}/share/sgml/events2ics.xsl ${.CURDIR}/events.xml

lint:
	${XMLLINT} --valid -o /dev/null ${.CURDIR}/events.xml

.if !make(install)
.PHONY:	curdate.xml
.endif
curdate.xml:
	@${ECHO} "Generating ${.TARGET}"
	@${ECHO_CMD} '<?xml version="1.0"?>'	 > ${.TARGET}
	@${ECHO_CMD} '<curdate>'		>> ${.TARGET}
	@${ECHO_CMD} -n '  <year>'		>> ${.TARGET}
	@${DATE} +%Y | ${TR} -d "\n"		>> ${.TARGET}
	@${ECHO_CMD} '</year>'			>> ${.TARGET}
	@${ECHO_CMD} -n '  <month>'		>> ${.TARGET}
	@${DATE} +%m | ${TR} -d "\n"		>> ${.TARGET}
	@${ECHO_CMD} '</month>'			>> ${.TARGET}
	@${ECHO_CMD} -n '  <day>'		>> ${.TARGET}
	@${DATE} +%d | ${TR} -d "\n"		>> ${.TARGET}
	@${ECHO_CMD} '</day>'			>> ${.TARGET}
	@${ECHO_CMD} '</curdate>'		>> ${.TARGET}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
