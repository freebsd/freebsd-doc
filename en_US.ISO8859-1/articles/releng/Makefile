# 
# $FreeBSD$
#
# Article: FreeBSD Release Engineering

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?= true

# SGML content
SRCS=  article.sgml branches.ascii

# IMAGES
IMAGES= branches.eps

CLEANFILES+= branches.ps branches.eps

DOC_PREFIX?= ${.CURDIR}/../../..

branches.eps: branches.pic
	${PIC2PS} branches.pic > branches.ps
	${PS2EPS} branches.ps branches.eps

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
