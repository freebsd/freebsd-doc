# $FreeBSD: www/en/news/status/Makefile,v 1.10 2001/11/12 22:25:12 chris Exp $

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
DATA+=	report-september-2001.html

# Install a sample <project> entry.
DATA+=	report-sample.xml

CLEANFILES+=	${DATA:M*.html}

.xml.html:	report.xsl includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/report.xsl ${.IMPSRC}
	-${TIDY} ${TIDYOPTS} ${.TARGET}

INDEXLINK=	status.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
