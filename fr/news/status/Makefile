# $FreeBSD: www/fr/news/status/Makefile,v 1.1 2002/12/22 22:05:07 stephane Exp $

# The FreeBSD French Documentation Project
# Original revision: 1.21

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.SUFFIXES:	.xml .html

DOCS=	status.sgml

# DATA=	report-june-2001.html
# DATA+=	report-july-2001.html
# DATA+=	report-august-2001.html
# DATA+=	report-september-2001.html
# DATA+=	report-november-2001.html
# DATA+=	report-dec-2001-jan-2002.html
# DATA+=	report-feb-2002-apr-2002.html
# DATA+=	report-may-2002-june-2002.html
DATA+=	report-july-2002-aug-2002.html
# DATA+=	report-sept-2002-oct-2002.html
# DATA+=	report-nov-2002-dec-2002.html
# DATA+=  	report-jan-2003-feb-2003.html
# DATA+=	report-mar-2003-sep-2003.html

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
