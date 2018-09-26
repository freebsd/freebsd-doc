# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=
DATA+=	cgi-lib.pl
DATA+=	cgi-style.pl

CGI=
CGI+=	fingerprints.cgi
CGI+=	getmsg.cgi
CGI+=	mailindex.cgi
CGI+=	man.cgi
CGI+=	mid.cgi
CGI+=	mirror.cgi
CGI+=	ports.cgi

.SUFFIXES:	.C .cgi

.C.cgi:
	${CXX} ${CFLAGS} -o ${.TARGET} ${.IMPSRC}

.include "${DOC_PREFIX}/share/mk/web.site.mk"
