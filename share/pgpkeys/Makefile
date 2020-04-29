# $FreeBSD$

DOC_PREFIX?=	${.CURDIR}/../..

XSLPGP=		http://www.FreeBSD.org/XML/share/xml/freebsd-pgpkeyring.xsl

FILES=		pgpkeyring.txt
CLEANFILES=	pgpkeyring.txt keyring.xml

.ORDER:	pgpkeyring pgpkeyring.txt
.ORDER:	keyring.xml pgpkeyring.txt

.DELETE_ON_ERROR:

all:	keyring.xml pgpkeyring pgpkeyring.txt

keyring.xml:	.PHONY
	@${ECHO_CMD} "<?xml version='1.0' encoding='UTF-8'?>" > ${.TARGET}
	@${ECHO_CMD} "<keyring>" >> ${.TARGET}
	@${CAT} *.key >> ${.TARGET}
	@${ECHO_CMD} "</keyring>" >> ${.TARGET}

pgpkeyring: keyring.xml
	@${XSLTPROC} ${XSLTPROCOPTS} ${XSLPGP} keyring.xml

pgpkeyring.txt:	.PHONY
	@${RM} -f ${.TARGET}.tmp || true
	@${MAKE} -C ${.CURDIR} pgpkeyring > ${.TARGET}.tmp
	${MV} ${.TARGET}.tmp ${.TARGET}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

.if defined(FINGERPRINTS_ONLY)
XSLTPROCOPTS+=--param generate.fingerprint.only '1'
.endif
