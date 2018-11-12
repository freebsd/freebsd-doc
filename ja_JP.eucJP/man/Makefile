# $FreeBSD$

PREFIX?=	/usr/share
SUBDIR?=	man1 man2 man3 man4 man5 man6 man7 man8 man9

makedb:
	LANG=ja_JP.EUC jmakewhatis ${DESTDIR}${PREFIX}/man/ja/

package:

.include <bsd.subdir.mk>
