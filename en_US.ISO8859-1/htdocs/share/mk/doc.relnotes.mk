# $FreeBSD$

DOC_PREFIX?= ../../../../

# XXX
RELEASETYPE!= grep -o 'release.type "[a-z]*"' ${RELN_ROOT}/share/xml/release.ent | sed 's|[a-z.]* "\([a-z]*\)"|\1|'
RELEASEURL!= grep -o 'release.url \"[^\"]*\"' ${RELN_ROOT}/share/xml/release.ent | sed 's|[^ ]* "\([^"]*\)"|\1|'
RELEASEBRANCH!= grep -o 'release.branch "\([^"]*\)"' ${RELN_ROOT}/share/xml/release.ent | sed 's|[^ ]* "\([^"]*\)"|\1|'
RELEASEMAILLIST!= grep -o 'release.maillist "\([^"]*\)"' ${RELN_ROOT}/share/xml/release.ent | sed 's|[^ ]* "\([^"]*\)"|\1|'
.if ${RELEASETYPE} == "current"
PROFILING+= --param profile.attribute "'releasetype'" --param profile.value "'current'"
.elif ${RELEASETYPE} == "snapshot"
PROFILING+= --param profile.attribute "'releasetype'" --param profile.value "'snapshot'"
.elif ${RELEASETYPE} == "release"
PROFILING+= --param profile.attribute "'releasetype'" --param profile.value "'release'"
.endif
XSLTPROCFLAGS+= --param release.url "'${RELEASEURL}'"
XSLTPROCFLAGS+= --param release.branch "'${RELEASEBRANCH}'"
XSLTPROCFLAGS+= --param release.maillist "'${RELEASEMAILLIST}'"
XSLTPROCFLAGS+=	--param toc.section.depth "'3'"

# Find the RELNOTESng document catalogs
EXTRA_CATALOGS+= file://${RELN_ROOT}/${LANGCODE}/share/xml/catalog.xml \
		 file://${RELN_ROOT}/share/xml/catalog.xml

XSLXHTML= file://${RELN_ROOT}/share/xml/release.xsl

.include "${DOC_PREFIX}/share/mk/doc.install.mk"
