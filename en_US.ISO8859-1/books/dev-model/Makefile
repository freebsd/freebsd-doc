#
# $FreeBSD$
#

MAINTAINER= des@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS= book.xml

IMAGES_EN= branches.png
IMAGES_EN+= freebsd-code-model.png
IMAGES_EN+= portsstatus.png
IMAGES_EN+= proc-add-committer.png
IMAGES_EN+= proc-commit.png
IMAGES_EN+= proc-contrib.png
IMAGES_EN+= proc-elections.png
IMAGES_EN+= proc-pr.png
IMAGES_EN+= proc-rm-committer.png

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
