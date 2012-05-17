# $FreeBSD: www/el/Makefile,v 1.1 2008/02/10 09:40:20 keramida Exp $

#
# The FreeBSD Greek Documentation Project
# Makefile for www/el directory (should be created)
#
# %SOURCE%	mn/Makefile
# %SRCID%	1.1

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# Subdirectories
# SGML
SUBDIR=	 FAQ
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
.endif

WEBDIR?=	data/el

.include "${WEB_PREFIX}/share/mk/web.site.mk"
