#
# Web site build hooks for the release notes.  Also see the README file.
#
# The variable RELNOTES (I couldn't think of a better name) is a poor
# man's list.  Its semantics are very similar to that of MLINKS (see
# bsd.man.mk).  The first word is the directory under which that set
# of relnotes should appear on the web site.  The second word is the
# path to that relnotes set.
#
# $FreeBSD: www/en/relnotes/Makefile,v 1.8 2008/10/05 10:17:00 simon Exp $
#

RELNOTES?=	CURRENT ${.CURDIR}/../../../relnotes/doc \
		8-STABLE ${.CURDIR}/../../../relnotes8/doc \
		7-STABLE ${.CURDIR}/../../../relnotes7/doc \
		6-STABLE ${.CURDIR}/../../../relnotes6/doc

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
				DOCDIR=${DESTDIR}/data/${.CURDIR:T}/$$webname \
				DOC_PREFIX=${.CURDIR}/../../../doc \
				DIRPRFX=${.CURDIR:T}/$$webname/ \
				NO_LANGCODE_IN_DESTDIR=true \
				${.TARGET}); \
	done;
