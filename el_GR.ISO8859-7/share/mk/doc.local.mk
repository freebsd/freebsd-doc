# $FreeBSD$
#
# Customizations to the FreeBSD doc/ makefile infrastructure that are
# specific to the el_GR.ISO8859-7 language.

SP_ENCODING?=	${LANGCODE:C,^.*\.,,}

PRINTFLAGS+=	-ioutput.for.print

# Don't use "?=" in the following two lines.
# They have been pre-defined in "doc.project.mk" and should be overridden here.
HTML2TXT=	${PREFIX}/bin/html2text
HTML2TXTOPTS=	-nobs -style pretty
