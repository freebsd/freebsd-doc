# $FreeBSD: www/en/cgi/Makefile,v 1.19 2002/11/09 05:23:14 bmah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=	ftp.mirrors
DATA+=	cvsweb.conf cvsweb.conf-freebsd cvsweb.conf-netbsd cvsweb.conf-openbsd
CGI=	ftp.cgi gallery.cgi mirror.cgi cgi-lib.pl cgi-style.pl
CGI+=	search.cgi cvsweb.cgi query-pr.cgi query-pr-summary.cgi
CGI+=	dosendpr.cgi sendpr-code.cgi
CGI+=	freebsd.def html.pl reg.cgi missing_handler.cgi
CGI+=	ports.cgi pds.cgi man.cgi url.cgi getmsg.cgi mid.cgi
CGI+=	mailindex.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
