# $FreeBSD: www/en/news/status/Makefile,v 1.6 2001/09/18 18:46:30 chris Exp $

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
DATA+=	report-august-2001.html

# Install a sample <project> entry.
DATA+=	report-sample.xml

CLEANFILES+=	${DATA}

.xml.html:	report.xsl includes.xsl
	xsltproc -nonet -o ${.TARGET} report.xsl ${.IMPSRC}
	-tidy -i -m -f /dev/null ${.TARGET}

INDEXLINK=	status.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
