#
# Build the Handbook with just the content from this chapter.
#
# $FreeBSD$
#

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS=   article.xml

IMAGES_EN=	vinum-concat.pic
IMAGES_EN+=	vinum-mirrored-vol.pic
IMAGES_EN+=	vinum-raid10-vol.pic
IMAGES_EN+=	vinum-raid5-org.pic
IMAGES_EN+=	vinum-simple-vol.pic
IMAGES_EN+=	vinum-striped-vol.pic
IMAGES_EN+=	vinum-striped.pic

URL_RELPREFIX?= ../../../..
DOC_PREFIX?=    ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

