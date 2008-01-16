# $FreeBSD: www/en/events/Makefile,v 1.13 2007/09/18 15:23:05 simon Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=  2002
SUBDIR+= 2003

DATA=	events.css
INDEXLINK=	events.html

XMLDOCS+=		events:${XSL_EVENTS}:${XML_EVENTS_EVENTS}:
DEPENDSET.events=	events

XMLDOCS+=		events_ics:${XSL_EVENTS_ICS}:${XML_EVENTS_EVENTS}:events.ics
DEPENDSET.events_ics=	events

XMLDOCS+=		events_rss:rss.xsl:${XML_EVENTS_EVENTS}:rss.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"
