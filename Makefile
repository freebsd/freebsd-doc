# $Id: Makefile,v 1.12 1999-08-19 20:31:25 nik Exp $

SUBDIR =	en_US.ISO_8859-1
SUBDIR+=	es_ES.ISO_8859-1
SUBDIR+=	ja_JP.eucJP
SUBDIR+=	ru_RU.KOI8-R
SUBDIR+=	zh_TW.Big5

.include <bsd.subdir.mk>
