#
# Web site build hooks for the release notes.  Also see the README file.
#
# The variable RELNOTES (I couldn't think of a better name) is a poor
# man's list.  Its semantics are very similar to that of MLINKS (see
# bsd.man.mk).  The first word is the directory under which that set
# of relnotes should appear on the web site.  The second word is the
# path to that relnotes set.
#
# $FreeBSD$
#

RELNOTES=	CURRENT ${.CURDIR}/../../../src/release/doc

all install clean obj:
	@set ${RELNOTES}; \
	while :; do \
		case $$# in \
			0) break;; \
			1) echo "bad \$$RELNOTES value"; false; break;; \
		esac; \
		webname=$$1; shift; realpath=$$1; shift; \
		(unset DESTDIR || true; \
			cd $$realpath && ${MAKE} \
				FORMATS=html\ html-split \
				DOCDIR=${DESTDIR}/data/${.CURDIR:T}/$$webname \
				DIRPRFX=${.CURDIR:T}/$$webname/ \
				${.TARGET}); \
	done;
