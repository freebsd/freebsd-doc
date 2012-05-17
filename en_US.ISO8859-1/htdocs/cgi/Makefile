# $FreeBSD: www/en/cgi/Makefile,v 1.35 2011/07/20 23:52:12 shaun Exp $

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

SUBDIR=	GnatsPR

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
