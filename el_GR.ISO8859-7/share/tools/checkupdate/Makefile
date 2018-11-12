# $FreeBSD$

SCRIPTS= checkupdate
MAN= checkupdate.1

CLEANFILES= ${SCRIPTS}

BINDIR?= ${HOME}/bin

.SUFFIXES:	.py

.py:
	cat ${.ALLSRC} > ${.TARGET}

.include <bsd.prog.mk>
