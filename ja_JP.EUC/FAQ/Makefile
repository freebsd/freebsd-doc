# $Id: Makefile,v 1.3 1998-01-24 17:57:13 hanai Exp $
# Original revision: 1.6
# The FreeBSD Japanese Documentation Project

DOC=    FAQ
DOCDIR= ${SHAREDIR}/doc/ja_JP.EUC
FORMATS?= html roff
SGMLOPTS=-e EUC-JP
SGMLOPTS+=-links

SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
