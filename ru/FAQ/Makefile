# $Id: Makefile,v 1.2 1998-12-30 10:17:35 dt Exp $

.NOTPARALLEL:

DOC=	FAQ
DOCDIR=	${SHAREDIR}/doc/ru
FORMATS?= html roff
SGMLOPTS+=-e koi8-r
SGMLOPTS+=-links
SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
