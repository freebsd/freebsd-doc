# $Id: Makefile,v 1.6 1998-07-24 05:31:24 hanai Exp $
# Original revision: 1.7
# The FreeBSD Japanese Documentation Project

.NOTPARALLEL:

DOC=    FAQ
DOCDIR= ${SHAREDIR}/doc/ja
FORMATS?= html roff
SGMLOPTS+=-e EUC-JP
SGMLOPTS+=-links

SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
