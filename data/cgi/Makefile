DATA=	ftp.mirrors
CGI=	ftp.cgi gallery.cgi mirror.cgi cgi-lib.pl cgi-style.pl
CGI+=	search.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "../web.mk"

