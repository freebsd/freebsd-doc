# $Id: Makefile,v 1.2 1999-01-31 18:21:28 vanilla Exp $

.NOTPARALLEL: 

DOC=	FAQ
DOCDIR= ${SHAREDIR/doc/zh
FORMATS?= html roff
SGMLOPTS=-links -e big5

SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
