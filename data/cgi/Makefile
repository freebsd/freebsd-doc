# $Id: Makefile,v 1.9 1997-10-11 15:58:11 wosch Exp $

DATA=	ftp.mirrors
CGI=	ftp.cgi gallery.cgi mirror.cgi cgi-lib.pl cgi-style.pl
CGI+=	search.cgi cvsweb.cgi query-pr.cgi query-pr-summary.cgi
CGI+= dosendpr.cgi freebsd.def html.pl reg.cgi missing_handler.cgi
CGI+=	ports.cgi pds.cgi man.cgi url.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "../web.mk"

