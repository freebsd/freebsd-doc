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

CLEANFILES+= branch.aux branch.log branch.dvi

DOC_PREFIX?= ${.CURDIR}/../../..

branch.dvi: branch.tex
	${LATEX} branch.tex

branches.eps: branch.dvi
	${DVIPS} -o ${.TARGET} -E branch.dvi

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
