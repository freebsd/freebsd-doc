# $FreeBSD: www/en/news/status/Makefile,v 1.14 2002/02/25 22:33:22 chris Exp $

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
DATA+=	report-november-2001.html
DATA+=	report-dec-2001-jan-2002.html
DATA+=	report-feb-2002-apr-2002.html

# Install a sample <project> entry.
DATA+=	report-sample.xml

CLEANFILES+=	${DATA:M*.html}

.xml.html:	report.xsl includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/report.xsl ${.IMPSRC}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

INDEXLINK=	status.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"
