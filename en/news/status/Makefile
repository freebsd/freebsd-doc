# $FreeBSD: www/en/news/status/Makefile,v 1.9 2001/10/29 10:14:32 murray Exp $

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
	${XSLTPROC} ${XSLTPROCFLAGS} -o ${.TARGET} \
		${.CURDIR}/report.xsl ${.IMPSRC}
	-${TIDY} ${TIDYFLAGS} ${.TARGET}

INDEXLINK=	status.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
