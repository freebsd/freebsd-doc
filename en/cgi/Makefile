# $Id: Makefile,v 1.6 1997-09-09 17:51:04 wosch Exp $

DATA=	ftp.mirrors
CGI=	ftp.cgi gallery.cgi mirror.cgi cgi-lib.pl cgi-style.pl
CGI+=	search.cgi cvsweb.cgi query-pr.cgi query-pr-summary.cgi
CGI+= dosendpr.cgi freebsd.def html.pl reg.cgi missing_handler.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "../web.mk"

