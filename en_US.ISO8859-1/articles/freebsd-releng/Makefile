#
# $FreeBSD$
#
# Article: FreeBSD Release Engineering

DOC?=		article

FORMATS?=	html html-split

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

SRCS=		article.xml

DEPS!= egrep '<!ENTITY release\.[^ ]+ SYSTEM "./releng-[^ ]+\.xml">' \
	${SRCS} | sed -E 's,.*"./([^"]+)".*,\1,'

CSS_SHEET_ADDITIONS=extra.css

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

index.html ${DOC}.html: ${DEPS}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
