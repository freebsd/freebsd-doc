# $Id: Makefile,v 1.1.1.1 1997-11-17 15:49:00 max Exp $
# Original revision: 1.6
# The FreeBSD Japanese Documentation Project

DOC=    FAQ
DOCDIR= ${SHAREDIR}/doc/ja_JP.EUC
FORMATS= html roff
SGMLOPTS+=-e EUC-JP
SGMLOPTS+=-links

SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
