# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

TIDY?=		/usr/local/bin/tidy
DOCS=	schedule.xml

HTMLFILES=	errata.html \
		hardware.html \
		readme.html \
		relnotes.html

DATA=	docbook.css

.include "${DOC_PREFIX}/share/mk/web.site.mk"

reformat:
.for _f in ${HTMLFILES}
	${TIDY} -preserve -omit -latin1 ${_f} > ${_f}.tmp || true
	mv ${_f}.tmp ${_f}
.endfor
