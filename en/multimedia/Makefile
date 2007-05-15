# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
.if exists(Makefile.inc)
.include "Makefile.inc"
.endif

INDEXLINK= multimedia.html

FXML = multimedia-input.xml
FHTML = \
	multimedia.html.intro \
	multimedia.html.pre \
	multimedia.html.post
FLIST = multimedia.created
FSCRIPT = multimedia.pl

DATA!=	cat ${FLIST}

all: ${FLIST}

clean:
	if test -f ${FLIST} ; then \
		xargs ${RM} < ${FLIST} && ${RM} ${FLIST} ; \
	fi

${FLIST}: ${FSCRIPT} ${FXML} ${FHTML}
	perl -Tw ${FSCRIPT}

.include "${WEB_PREFIX}/share/mk/web.site.mk"
