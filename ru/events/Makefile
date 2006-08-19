#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD: www/ru/events/Makefile,v 1.1 2005/06/18 05:58:59 andy Exp $
# $FreeBSDru: frdp/www/ru/events/Makefile,v 1.3 2005/06/18 06:00:21 andy Exp $
#
# Original revision: 1.7
#

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=	2003
#SUBDIR+= 2003

DATA=	events.css

XMLDOCS+=		events:${XSL_EVENTS}:${XML_EVENTS_EVENTS}:
DEPENDSET.events=	events

XMLDOCS+=		events_ics:${XSL_EVENTS_ICS}:${XML_EVENTS_EVENTS}:events.ics
DEPENDSET.events_ics=	events

.include "${WEB_PREFIX}/share/mk/web.site.mk"
