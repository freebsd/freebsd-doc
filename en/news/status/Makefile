# $FreeBSD: www/en/news/status/Makefile,v 1.2 2001/08/09 16:13:38 chris Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.SUFFIXES:	.xml .html

DOCS=	status.sgml

DATA=	report-june-2001.html
DATA+=	report-july-2001.html

CLEANFILES+=	${DATA}

.xml.html:
	xsltproc -nonet -o ${.TARGET} report.xsl ${.IMPSRC}
	-tidy -i -m -f /dev/null ${.TARGET}

INDEXLINK=	status.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
