# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.21

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.SUFFIXES:	.xml .html

DOCS=	status.xml

#XMLDOCS=	report-june-2001
#XMLDOCS+=	report-july-2001
#XMLDOCS+=	report-august-2001
#XMLDOCS+=	report-september-2001
#XMLDOCS+=	report-november-2001
#XMLDOCS+=	report-dec-2001-jan-2002
#XMLDOCS+=	report-feb-2002-apr-2002
#XMLDOCS+=	report-may-2002-june-2002
XMLDOCS+=	report-july-2002-aug-2002
#XMLDOCS+=	report-sept-2002-oct-2002
#XMLDOCS+=	report-nov-2002-dec-2002
#XMLDOCS+=	report-jan-2003-feb-2003
#XMLDOCS+=	report-mar-2003-sep-2003
#XMLDOCS+=	report-oct-2003-dec-2003
#XMLDOCS+=	report-jan-2004-feb-2004
#XMLDOCS+=	report-mar-2004-apr-2004
#XMLDOCS+=	report-may-2004-june-2004
#XMLDOCS+=	report-july-2004-dec-2004
#XMLDOCS+=	report-jan-2005-mar-2005
#XMLDOCS+=	report-mar-2005-june-2005
#XMLDOCS+=	report-july-2005-oct-2005
#XMLDOCS+=	report-oct-2005-dec-2005
#XMLDOCS+=	report-jan-2006-mar-2006
#XMLDOCS+=	report-apr-2006-jun-2006

XSLT.DEFAULT=	report.xsl

# Install a sample <project> entry.
DATA=		report-sample.xml

INDEXLINK=	status.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"
