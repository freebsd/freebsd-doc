# $Id: Makefile,v 1.11 1999-08-17 22:12:29 nik Exp $

SUBDIR =	en_US.ISO_8859-1
SUBDIR+=	es_ES.ISO_8859-1
SUBDIR+=	ja_JP.eucJP
SUBDIR+=	ru_SU.KOI8-R
SUBDIR+=	zh_TW.Big5

.include <bsd.subdir.mk>
