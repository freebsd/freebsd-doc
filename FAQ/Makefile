# $Id: Makefile,v 1.8 1999-08-17 21:35:50 nik Exp $

.NOTPARALLEL: 

SGMLOPTS=-links
DOC=	FAQ
VOLUME= faq
DOCDIR= /usr/local/share/doc/fdp/en_US.ISO_8859-1/books
SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

beforeinstall:
	[ -d /usr/local/share/doc/fdp/en_US.ISO_8859-1/books/faq ] || \
		mkdir -p /usr/local/share/doc/fdp/en_US.ISO_8859-1/books/faq

.include <bsd.sgml.mk>
