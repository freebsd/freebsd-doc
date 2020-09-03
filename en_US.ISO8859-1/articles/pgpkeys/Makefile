#
# $FreeBSD$
#
# Article: PGP Keys

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS=	article.xml

# To build with just key fingerprints, set FINGERPRINTS_ONLY.

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# XXXHRS temporary measure to handle PGP key dependency
.PATH: ${DOC_PREFIX}/share/pgpkeys
.for f in ${FORMATS:Ntxt}
${DOC}.${f}: ${_DEPENDSET.pgpkeys}
.endfor
