# $FreeBSD: www/en/cgi/Makefile,v 1.25 2005/10/06 15:44:08 remko Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=
DATA+=	Gnats.pm
DATA+=	cgi-lib.pl
DATA+=	cgi-style.pl
DATA+=	cvsweb.conf
DATA+=	cvsweb.conf-freebsd
DATA+=	cvsweb.conf-netbsd
DATA+=	cvsweb.conf-openbsd
DATA+=	ftp.mirrors
DATA+=	html.pl

CGI=
CGI+=	cvsweb.cgi
CGI+=	dosendpr.cgi
CGI+=	ftp.cgi
CGI+=	gallery.cgi
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
CGI+=	sendpr-code.cgi
CGI+=	url.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
