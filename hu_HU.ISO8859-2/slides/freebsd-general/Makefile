#
# $FreeBSD$
#
# %SOURCE%    en_US.ISO8859-1/slides/freebsd-general/Makefile
# %SRCID%     1.1
#
# Build an example FreeBSD Presentation
#

DOCFORMAT=	slides
DOC=		slides

FORMATS?= html

SRCS=	slides.xml
SRCS+=	../common/freebsd-recent-releases.xml
SRCS+=	../common/freebsd-5.3.xml
SRCS+=	../common/what-is-freebsd.xml
SRCS+=	../common/freebsd-organization.xml
SRCS+=	../common/freebsd-dev-model.xml
SRCS+=	../common/freebsd-release-process.xml

XSLTPROCFLAGS=	--nonet --xinclude --stringparam draft.mode no
XSLTPROCOPTS=	${XSLTPROCFLAGS}

DOC_PREFIX?=	${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"
