# Makefile to build the Handbook from DocBook source.
#
# Requires these ports from textproc
#
#    docbook
#    dsssl-docbook-modular
#    html
#    jade
#
# and probably one or two others. You can probably get everything you need
# with the new textproc/docproj meta-port. 
#
# Note that you need version 1.08 of dsssl-docbook-modular. In version 1.07
# the 'catalog' file is called 'CATALOG', and you will need to change the 
# definition below.
#
# THIS IS A QUICK HACK (!) so that others can get an idea of how the 
# Handbook will look after conversion. After typing "make", point your
# browser at book01.html and read on. This is still very much a work in
# progress, and the final formatting will be considerably different.
#
# Eventually I expect most of this will be folded back into bsd.sgml.mk.
#
# Any comments or suggestions about the conversion process should be sent
# to nik@FreeBSD.ORG
#

MAINTAINER=nik@FreeBSD.ORG

DOCS=	handbook.sgml

# ------------------------------------------------------------------------
#
# Transformation rules
#

# file.sgml --> file.html
#
# Examines file.sgml to determine the DTD in use. The DTD determines how
# the file will be converted to HTML. 

.SUFFIXES:	.sgml .html
SGMLNORM?=	/usr/local/bin/sgmlnorm
HTMLCATALOG?=	/usr/local/share/sgml/html/catalog
SGMLNORMFLAGS=	-d -n -c ${HTMLCATALOG}

JADE?=		/usr/local/bin/jade
DSL?=           ../../sgml/freebsd.dsl
FREEBSDCATALOG?=../../sgml/catalog
DOCBOOKCATALOG?=/usr/local/share/sgml/docbook/3.0/catalog
JADECATALOG?=	/usr/local/share/sgml/jade/catalog
DSSSLCATALOG?=  /usr/local/share/sgml/docbook/dsssl/modular/catalog
JADEFLAGS?=	-c ${FREEBSDCATALOG} -c ${DSSSLCATALOG} -c ${DOCBOOKCATALOG} -c ${JADECATALOG} -d ${DSL} -t sgml

.sgml.html:
	@DTD=`head -n 1 ${.IMPSRC} | perl -ne '/DTD (\w+)/; print $$1;'`;  \
	echo "${.IMPSRC} ($$DTD) --> ${.TARGET}";			\
	case $$DTD in							\
		HTML)							\
			${SGMLNORM} ${SGMLNORMFLAGS}			\
				${.IMPSRC} > ${.TARGET}; 		\
			;;						\
		DocBook)						\
			${JADE} ${JADEFLAGS} ${.IMPSRC};		\
			;;						\
		*)							\
			echo "Don't know how to process $$DTD."		\
			;;						\
	esac

#	${SGMLNORM} ${SGMLNORMFLAGS} ${.IMPSRC} > ${.TARGET}

# ------------------------------------------------------------------------
#
# Targets
#

# If no target is specifed then .MAIN is made
.MAIN: all

#
# Build everything. Never completes, because handbook.html is never built
#
all: handbook.html

