# $FreeBSD: www/en/commercial/Makefile,v 1.15 2004/05/02 21:53:07 josef Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=   commercial.sgml

DATA=	consult.html
DATA+=	consult_bycat.html
DATA+=  hardware.html
DATA+=  isp.html
DATA+=  misc.html
DATA+=  software.html
DATA+=  software_bycat.html

CLEANFILES=  commercial.html
CLEANFILES+= consult.html
CLEANFILES+= consult_bycat.html
CLEANFILES+= hardware.html
CLEANFILES+= isp.html
CLEANFILES+= misc.html
CLEANFILES+= software.html
CLEANFILES+= software_bycat.html

INDEXLINK= commercial.html

XMLLINT?= /usr/local/bin/xmllint # Part of textproc/libxml2.

consult.html: entries.xsl consult.xml ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param pagename "'Consulting Services'" \
		${.CURDIR}/entries.xsl ${.CURDIR}/consult.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

consult_bycat.html: consult_bycat.xsl consult.xml ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/consult_bycat.xsl ${.CURDIR}/consult.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

hardware.html: entries.xsl hardware.xml ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param pagename "'Hardware Vendors'" \
		${.CURDIR}/entries.xsl ${.CURDIR}/hardware.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

isp.html: entries.xsl isp.xml ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param pagename "'Internet Service Providers'" \
		${.CURDIR}/entries.xsl ${.CURDIR}/isp.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

misc.html: entries.xsl misc.xml ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param pagename "'Miscellaneous Vendors'" \
		${.CURDIR}/entries.xsl ${.CURDIR}/misc.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

software.html: entries.xsl software.xml ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		--param pagename "'Software Vendors'" \
		${.CURDIR}/entries.xsl ${.CURDIR}/software.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

software_bycat.html: soft_bycat.xsl software.xml ../includes.xsl
	${XSLTPROC} ${XSLTPROCOPTS} -o ${.TARGET} \
		${.CURDIR}/soft_bycat.xsl ${.CURDIR}/software.xml
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

lint:
	${XMLLINT} --valid -o /dev/null ${.CURDIR}/consult.xml
	${XMLLINT} --valid -o /dev/null ${.CURDIR}/hardware.xml
	${XMLLINT} --valid -o /dev/null ${.CURDIR}/isp.xml
	${XMLLINT} --valid -o /dev/null ${.CURDIR}/misc.xml
	${XMLLINT} --valid -o /dev/null ${.CURDIR}/software.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"
