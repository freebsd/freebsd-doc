# $FreeBSD: www/en/events/Makefile,v 1.9 2005/09/18 04:33:45 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=  2002
SUBDIR+= 2003

DATA=	events.css

CLEANFILES+= curdate.xml

XMLLINT?= /usr/local/bin/xmllint # Part of textproc/libxml2.

XMLDOCS+=	events
DEPENDSET.events=	events

XMLDOCS+=	events_ics:${WEB_PREFIX}/share/sgml/events2ics.xsl:events.xml:events.ics

lint:
	${XMLLINT} ${XMLLINTOPTS} --valid -o /dev/null ${.CURDIR}/events.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"
