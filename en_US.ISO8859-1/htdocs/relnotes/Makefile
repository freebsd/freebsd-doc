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
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

RELNOTES?=	CURRENT ${DOC_PREFIX}/../relnotes/doc/${LANGCODE} \
		10-STABLE ${DOC_PREFIX}/../relnotes10/doc/${LANGCODE} \
		9-STABLE ${DOC_PREFIX}/../relnotes9/doc/${LANGCODE}

.include "Makefile.inc"
