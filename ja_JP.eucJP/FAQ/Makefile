# $Id: Makefile,v 1.7 1999-08-16 22:09:13 nik Exp $
# Original revision: 1.7
# The FreeBSD Japanese Documentation Project

.NOTPARALLEL:

DOC=    FAQ
VOLUME=	faq
DOCDIR= /usr/local/share/doc/fdp/ja/books
FORMATS?= html roff
SGMLOPTS+=-e EUC-JP
SGMLOPTS+=-links

SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
