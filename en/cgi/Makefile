# $FreeBSD: www/en/cgi/Makefile,v 1.34 2007/03/19 05:44:58 dougb Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=
DATA+=	Gnats.pm
DATA+=	GnatsPR.pm
DATA+=	cgi-lib.pl
DATA+=	cgi-style.pl
DATA+=	cvsweb.conf
DATA+=	cvsweb.conf-freebsd
DATA+=	query-pr-lib.pl

CGI_SUBDIRS=	GnatsPR GnatsPR/Section

CGI_SUBFILES+=	GnatsPR/MIMEIterator.pm
CGI_SUBFILES+=	GnatsPR/Section.pm
CGI_SUBFILES+=	GnatsPR/Section/Email.pm
CGI_SUBFILES+=	GnatsPR/Section/FieldStart.pm
CGI_SUBFILES+=	GnatsPR/Section/MIME.pm
CGI_SUBFILES+=	GnatsPR/Section/Patch.pm
CGI_SUBFILES+=	GnatsPR/Section/StateChange.pm
CGI_SUBFILES+=	GnatsPR/Section/Text.pm
CGI_SUBFILES+=	GnatsPR/SectionIterator.pm

CGI=
CGI+=	confirm-code.cgi
CGI+=	cvsweb.cgi
CGI+=	dosendpr.cgi
CGI+=	getmsg.cgi
CGI+=	mailindex.cgi
CGI+=	man.cgi
CGI+=	mid.cgi
CGI+=	mirror.cgi
CGI+=	missing_handler.cgi
CGI+=	monthly.cgi
CGI+=	pds.cgi
CGI+=	ports.cgi
CGI+=	query-pr.cgi
CGI+=	query-pr-summary.cgi
CGI+=	search.cgi
CGI+=	url.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
