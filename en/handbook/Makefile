# 
# $Id: Makefile,v 1.5 1998-11-12 01:20:35 nik Exp $
#
# Build the FreeBSD Handbook. Will eventually split in two, a generic .mk
# file which can be used by many Makefiles, and a much smaller Makefile
# which uses the generic.mk file.
#
# Note: Doing all this in a Makefile is a little odd. This is because there
# is typically not a 1:1 mapping between the .sgml files and the .html,
# .rtf, .ps, and other formats. For most of them, all the .sgml files will
# become one file in the chosen output format. For HTML, many .html files
# will be produced, but they won't be named after the corresponding .sgml
# files.

MAINTAINER=nik@FreeBSD.ORG

#
# DOC is the root name of file(s) that will be generated (i.e, for
# foo.rtf, foo.ps, etc, DOC=foo. HTML generation ignores this, it 
# is assumed that the stylesheet names this. If not set, DOC defaults
# to the name of the current directory.
#
DOC?= ${.CURDIR:T}

#
# FORMATS lists the output formats that should be generated. Valid values
# are 
#
#    ascii html ps pdf rtf
#
FORMATS=  html

# 
# SRCS lists the individual SGML files that make up the Handbook. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  handbook.sgml
SRCS+= advanced-networking/chapter.sgml
SRCS+= backups/chapter.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= contrib/chapter.sgml
SRCS+= cutting-edge/chapter.sgml
SRCS+= disks/chapter.sgml
SRCS+= eresources/chapter.sgml
SRCS+= hw/chapter.sgml
SRCS+= install/chapter.sgml
SRCS+= internals/chapter.sgml
SRCS+= introduction/chapter.sgml
SRCS+= kernelconfig/chapter.sgml
SRCS+= kerneldebug/chapter.sgml
SRCS+= kernelopts/chapter.sgml
SRCS+= l10n/chapter.sgml
SRCS+= linuxemu/chapter.sgml
SRCS+= mail/chapter.sgml
SRCS+= mirrors/chapter.sgml
SRCS+= pgpkeys/chapter.sgml
SRCS+= policies/chapter.sgml
SRCS+= ppp-and-slip/chapter.sgml
SRCS+= printing/chapter.sgml
SRCS+= quotas/chapter.sgml
SRCS+= security/chapter.sgml
SRCS+= serialcomms/chapter.sgml
SRCS+= staff/chapter.sgml
SRCS+= x11/chapter.sgml
SRCS+= ports/chapter.sgml

# Entities
SRCS+= authors.ent chapters.ent mailing-lists.ent


JADE=		/usr/local/bin/jade
DSLHTML=	../../sgml/freebsd.dsl
DSLPRINT=	/usr/local/share/sgml/docbook/dsssl/modular/print/docbook.dsl

FREEBSDCATALOG= ../../sgml/catalog
DOCBOOKCATALOG= /usr/local/share/sgml/docbook/3.0/catalog
JADECATALOG=	/usr/local/share/sgml/jade/catalog
DSSSLCATALOG=   /usr/local/share/sgml/docbook/dsssl/modular/catalog

JADEFLAGS?=	-c ${FREEBSDCATALOG} -c ${DSSSLCATALOG} -c ${DOCBOOKCATALOG} -c ${JADECATALOG}

# ------------------------------------------------------------------------
#
# Look at ${FORMATS} and work out which documents need to be generated.
# It is assumed that the HTML transformation will always create a file
# called index.html, and that for every other transformation the name
# of the generated file is ${DOC}.format.
#
# ${_docs} will be set to a list of all documents that must be made
# up to date.

.for _curformat in ${FORMATS}
_cf=${_curformat}
.if ${_cf} == "html"
_docs+= index.html
CLEANFILES+= *.html HTML.manifest
.else
_docs+= ${DOC}.${_curformat}
CLEANFILES+= ${DOC}.${_curformat}
.endif
.endfor

# ------------------------------------------------------------------------
#
# Build some targets

# ------------------------------------------------------------------------
#
# Targets
#

# If no target is specifed then .MAIN is made
.MAIN: all

all: ${_docs}

index.html: ${SRCS}
	${JADE} ${JADEFLAGS} -d ${DSLHTML} -t sgml handbook.sgml
	./conv.pl *.html

${DOC}.rtf: ${SRCS}
	${JADE} ${JADEFLAGS} -d ${DSLPRINT} -t rtf handbook.sgml

${DOC}.tex: ${SRCS}
	${JADE} ${JADEFLAGS} -d ${DSLPRINT} -t tex handbook.sgml

.include <bsd.dep.mk>
.include <bsd.obj.mk>
