TIDYFLAGS=   -raw

.if defined(OPENJADE)
JADE=       SP_ENCODING=ISO-8859-2 ${PREFIX}/bin/openjade
.else
JADE=       SP_ENCODING=ISO-8859-2 ${PREFIX}/bin/jade
.endif

DESTDIR?=    ${DOCDIR}/sr_YU.ISO_8859-2/books/${.CURDIR:T}
