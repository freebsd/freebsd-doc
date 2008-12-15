# $FreeBSD: www/en/events/Makefile,v 1.15 2008/06/22 23:18:55 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=  2002
SUBDIR+= 2003

# The year the top level events.html file starts from:
YEARSTART= 2008
# Years to generate past events pages for and link from top level:
PASTYEARS= 2003 2004 2005 2006 2007

DATA=	events.css
INDEXLINK=	events.html

XMLDOCS+=		events:${XSL_EVENTS}:${XML_EVENTS_EVENTS}:
PARAMS.events=		--param startyear ${YEARSTART}
PARAMS.events+=		--stringparam pastyears '${PASTYEARS}'
DEPENDSET.events=	events

.for year in ${PASTYEARS}
XMLDOCS+=		events${year}:${XSL_EVENTS_PAST}:${XML_EVENTS_EVENTS}:
PARAMS.events${year}=	--param year ${year}
DEPENDSET.events${year}= events${year}
.endfor

XMLDOCS+=		events_ics:${XSL_EVENTS_ICS}:${XML_EVENTS_EVENTS}:events.ics
DEPENDSET.events_ics=	events

XMLDOCS+=		events_rss:rss.xsl:${XML_EVENTS_EVENTS}:rss.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"
