# The FreeBSD Russian Documentation Project
#
# Web site build hooks for the release notes.  Also see the README file.
#
# The variable RELNOTES (I couldn't think of a better name) is a poor
# man's list.  Its semantics are very similar to that of MLINKS (see
# bsd.man.mk).  The first word is the directory under which that set
# of relnotes should appear on the web site.  The second word is the
# path to that relnotes set.
#
# $FreeBSDru: frdp/www/ru/relnotes/Makefile,v 1.2 2004/09/10 14:21:53 den Exp $
# $FreeBSD$
#
# Original revision: 1.6 
#

RELNOTES?=	CURRENT ${.CURDIR}/../../../relnotes/doc/ru_RU.KOI8-R \
		5-STABLE ${.CURDIR}/../../../relnotes5/doc/ru_RU.KOI8-R

all install clean obj:
	@set ${RELNOTES}; \
	while :; do \
		case $$# in \
			0) break;; \
			1) ${ECHO_CMD} "bad \$$RELNOTES value"; false; break;; \
		esac; \
		webname=$$1; shift; realpath=$$1; shift; \
		(unset DESTDIR || true; \
			cd $$realpath && ${MAKE} \
				FORMATS=html\ html-split \
				DOCDIR=${DESTDIR}/data/ru/${.CURDIR:T}/$$webname \
				DOC_PREFIX=${.CURDIR}/../../../doc \
				DIRPRFX=${.CURDIR:T}/$$webname/ \
				NO_LANGCODE_IN_DESTDIR=true \
				${.TARGET}); \
	done;
