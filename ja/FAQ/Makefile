# $Id: Makefile,v 1.2 1997-12-28 08:37:48 asami Exp $
# Original revision: 1.6
# The FreeBSD Japanese Documentation Project

DOC=    FAQ
DOCDIR= ${SHAREDIR}/doc/ja_JP.EUC
FORMATS?= html roff
SGMLOPTS+=-e EUC-JP
SGMLOPTS+=-links

SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
