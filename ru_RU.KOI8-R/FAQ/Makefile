# $FreeBSD$

.NOTPARALLEL:

DOC=	FAQ
DESTDIR=	${DOCDIR}/ru_RU.KOI8-R
FORMATS?= html roff
SGMLOPTS+=-e koi8-r
SGMLOPTS+=-links
SRCS= FAQ.sgml acknowledgments.sgml admin.sgml applications.sgml
SRCS+= commercial.sgml hackers.sgml hardware.sgml install.sgml
SRCS+= kernelconfig.sgml misc.sgml network.sgml preface.sgml
SRCS+=	serial.sgml troubleshoot.sgml x.sgml

.include <bsd.sgml.mk>
