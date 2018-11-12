#
# $FreeBSD$
#
# This include file <doc.docbook-dep.mk> handles implicit dependencies of
# DocBook documentation in the FreeBSD Documentation Project.
#

#
# extract the depending *.xml files from the main
# input sources on the fly:
#
# <!ENTITY release.building SYSTEM "./releng-building.xml">
#
# 	=> ./releng-building.xml
#

.if make(all)
_DOCBOOK_DEPS_SYSTEM != for i in $$(egrep '<!ENTITY [^ ]+ SYSTEM "[^ ]+\.xml">' ${SRCS} | sed -E 's,.*"([^"]+)".*,\1,');do \
			  if [ -e $$i ]; then \
			    echo $i; \
			  else \
			    echo "Warning: dep file $$(pwd)/$$i does not exist" >&2; \
			  fi; \
			done
.endif

DOCBOOK_DEPS += ${_DOCBOOK_DEPS_SYSTEM}

index.html ${DOC}.html: ${DOCBOOK_DEPS}

