# $FreeBSD: www/en/events/Makefile,v 1.11 2005/10/05 04:55:34 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=  2002
SUBDIR+= 2003

DATA=	events.css

XMLDOCS+=		events:${XSL_EVENTS}:${XML_EVENTS_EVENTS}:
DEPENDSET.events=	events

XMLDOCS+=		events_ics:${XSL_EVENTS_ICS}:${XML_EVENTS_EVENTS}:events.ics
DEPENDSET.events_ics=	events

.include "${WEB_PREFIX}/share/mk/web.site.mk"
