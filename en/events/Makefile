# $FreeBSD: www/en/events/Makefile,v 1.10 2005/10/04 18:28:28 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=  2002
SUBDIR+= 2003
DATE?= /bin/date
TR?= /usr/bin/tr

DATA=	events.css

CLEANFILES+= curdate.xml

XMLLINT?= /usr/local/bin/xmllint # Part of textproc/libxml2.

XMLDOCS+=	events
DEPENDSET.events=	events curdate.xml
SRCS.events=	../includes.xsl curdate.xml

XMLDOCS+=	events_ics:${WEB_PREFIX}/share/sgml/events2ics.xsl:events.xml:events.ics

lint:
	${XMLLINT} ${XMLLINTOPTS} --valid -o /dev/null ${.CURDIR}/events.xml

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
