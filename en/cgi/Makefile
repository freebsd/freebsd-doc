# $FreeBSD: www/en/cgi/Makefile,v 1.22 2004/02/16 16:57:10 ceri Exp $

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
CGI+=	reg.cgi missing_handler.cgi
CGI+=	ports.cgi pds.cgi man.cgi url.cgi getmsg.cgi mid.cgi
CGI+=	mailindex.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
