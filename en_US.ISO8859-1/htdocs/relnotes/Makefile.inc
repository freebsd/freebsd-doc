#
# $FreeBSD$
#
RELNOTES?=	CURRENT ${DOC_PREFIX}/../relnotes/doc/${LANGCODE}

all install clean obj:
	@set ${RELNOTES}; \
	while :; do \
		case $$# in \
			0) break;; \
			1) ${ECHO_CMD} "bad \$$RELNOTES value"; false; break;; \
		esac; \
		webname=$$1; shift; realpath=$$1; shift; \
		(unset DESTDIR || true; \
			cd $$realpath && ${MAKE} \
				FORMATS=html\ html-split \
				DOCDIR=${DESTDIR}${WEBBASE}/${.CURDIR:T}/$$webname \
				DOC_PREFIX=${DOC_PREFIX} \
				DIRPRFX=${.CURDIR:T}/$$webname/ \
				LANGCODE=${LANGCODE} \
				NO_LANGCODE_IN_DESTDIR=true \
				${.TARGET}); \
	done;

.include "${DOC_PREFIX}/share/mk/web.site.mk"
