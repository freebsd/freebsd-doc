#
#    The FreeBSD Documentation Project
#    The FreeBSD French Documentation Project
#
#    Compilation de la FAQ FreeBSD
#
#    $FreeBSD$
#    Original revision: 1.5
#

MAINTAINER=nik@FreeBSD.ORG

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml 
SRCS+= acknowledgments.sgml 
SRCS+= admin.sgml 
SRCS+= applications.sgml 
SRCS+= commercial.sgml 
SRCS+= hackers.sgml 
SRCS+= hardware.sgml 
SRCS+= includes.sgml 
SRCS+= install.sgml 
SRCS+= kernelconfig.sgml 
SRCS+= misc.sgml 
SRCS+= network.sgml 
SRCS+= preface.sgml 
SRCS+= serial.sgml 
SRCS+= troubleshoot.sgml 
SRCS+= x.sgml 

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"
