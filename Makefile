# $Id: Makefile,v 1.10 1999-08-16 22:09:03 nik Exp $

SUBDIR =	FAQ 
SUBDIR+=	en_US.ISO_8859-1
SUBDIR+=	es_ES.ISO_8859-1
SUBDIR+=	ja_JP.eucJP
SUBDIR+=	ru_SU.KOI8-R
SUBDIR+=	zh_TW.Big5

.include <bsd.subdir.mk>
