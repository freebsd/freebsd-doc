# $Id: Makefile,v 1.3 1999-02-02 06:44:38 vanilla Exp $

.NOTPARALLEL: 

DOC=	FAQ
DOCDIR= ${SHAREDIR}/doc/zh
FORMATS?= html roff
SGMLOPTS=-links -e big5

SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
