# $FreeBSD: www/en/cgi/Makefile,v 1.24 2005/04/09 12:45:52 mlaier Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=	ftp.mirrors html.pl cgi-lib.pl cgi-style.pl Gnats.pm
DATA+=	cvsweb.conf cvsweb.conf-freebsd cvsweb.conf-netbsd cvsweb.conf-openbsd
CGI=	ftp.cgi gallery.cgi mirror.cgi
CGI+=	search.cgi cvsweb.cgi query-pr.cgi query-pr-summary.cgi
CGI+=	dosendpr.cgi sendpr-code.cgi
CGI+=	missing_handler.cgi
CGI+=	ports.cgi pds.cgi man.cgi url.cgi getmsg.cgi mid.cgi
CGI+=	mailindex.cgi monthly.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
