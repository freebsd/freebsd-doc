# Taken from:
#	Id: bsd.subdir.mk,v 1.27 1999/03/21 06:43:40 bde
#
# $FreeBSD: doc/share/mk/doc.subdir.mk,v 1.5 2000/10/29 02:39:10 nik Exp $
#
# This include file <doc.subdir.mk> contains the default targets
# for building subdirectories in the FreeBSD Documentation Project.
#
# For all of the directories listed in the variable SUBDIR, the
# specified directory will be visited and the target made. There is
# also a default target which allows the command "make subdir" where
# subdir is any directory listed in the variable SUBDIR.
#

# ------------------------------------------------------------------------
#
# Document-specific variables:
#
#	SUBDIR			A list of subdirectories that should be
#				built as well.  Each of the targets will
#				execute the same target in the
#				subdirectories.
#
#	COMPAT_SYMLINK		Create a symlink named in this variable
#				to this directory, when installed.
#
#	ROOT_SYMLINKS		Create symlinks to the named directories
#				in the document root, if the current
#				language is the primary language (the
#				PRI_LANG variable).
#

# ------------------------------------------------------------------------
#
# Provided targets:
#
#	install:
#	package:
#			Go down subdirectories and call these targets
#			along the way, and then call the real target
#			here.
#
#	clean:
#			Remove files created by the build process.
#
#	cleandir:
#			Remove the object directory, if any.
#

.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif

# ------------------------------------------------------------------------
#
# Work out the language and encoding used for this document.
#
# Liberal default of maximum of 5 directories below to find it.
#

.if !defined(LANGCODE)
LANGCODE:=	${.CURDIR}
.for _ in 1 2 3 4 5 6 7 8 9 10
.if !(${LANGCODE:H:T} == "doc")
LANGCODE:=	${LANGCODE:H}
.endif
.endfor
LANGCODE:=	${LANGCODE:T}
.endif


.if !target(install)
install: afterinstall symlinks 
afterinstall: realinstall
realinstall: beforeinstall _SUBDIRUSE
.endif

package: realpackage symlinks
realpackage: _SUBDIRUSE

.if !defined(IGNORE_COMPAT_SYMLINK) && defined(COMPAT_SYMLINK)
SYMLINKS+= ${DOCDIR} ${.CURDIR:T:ja_JP.eucJP=ja} ${COMPAT_SYMLINK:ja=ja_JP.eucJP}
.endif

.if defined(PRI_LANG) && defined(ROOT_SYMLINKS) && !empty(ROOT_SYMLINKS)
.if ${PRI_LANG} == ${LANGCODE}
.for _tmp in ${ROOT_SYMLINKS}
SYMLINKS+= ${DOCDIR} ${LANGCODE:ja_JP.eucJP=ja}/${.CURDIR:T}/${_tmp} ${_tmp}
.endfor
.endif
.endif

.if !target(symlinks)
symlinks:
.if defined(SYMLINKS) && !empty(SYMLINKS)
	@set `echo ${SYMLINKS}`; \
	while : ; do \
		case $$# in \
			0) break;; \
			[12]) echo "warn: empty SYMLINKS: $$1 $$2"; break;; \
		esac; \
		d=$$1; shift; \
		l=$$1; shift; \
		t=$$1; shift; \
		if [ ! -e $${d}/$${l} ]; then \
			${ECHO} "$${d}/$${l} doesn't exist, not linking"; \
		else \
			${ECHO} $${d}/$${t} -\> $${d}/$${l}; \
			(cd $${d} && rm -rf $${t}); \
			(cd $${d} && ln -s $${l} $${t}); \
		fi; \
	done
.endif
.endif

.for __target in beforeinstall afterinstall realinstall realpackage
.if !target(${__target})
${__target}:
.endif
.endfor

_SUBDIRUSE: .USE
.for entry in ${SUBDIR}
	@${ECHO} "===> ${DIRPRFX}${entry}"
	@(cd ${.CURDIR}/${entry} && \
	${MAKE} ${.TARGET:S/realpackage/package/:S/realinstall/install/} DIRPRFX=${DIRPRFX}${entry}/ )
.endfor

.if !defined(NOINCLUDEMK)

.include <bsd.obj.mk>
.include <bsd.subdir.mk>

.else

.MAIN: all

${SUBDIR}::
	cd ${.CURDIR}/${.TARGET}
	${MAKE} all

.for __target in all cleandir lint objlink install
.if !target(${__target})
${__target}: _SUBDIRUSE
.endif
.endfor

.if !target(obj)
obj:	_SUBDIRUSE
	@if ! test -d ${CANONICALOBJDIR}/; then \
		mkdir -p ${CANONICALOBJDIR}; \
		if ! test -d ${CANONICALOBJDIR}/; then \
			${ECHO} "Unable to create ${CANONICALOBJDIR}."; \
			exit 1; \
		fi; \
		${ECHO} "${CANONICALOBJDIR} created ${.CURDIR}"; \
	fi
.endif

.if !target(objlink)
objlink: _SUBDIRUSE
	@if test -d ${CANONICALOBJDIR}/; then \
		rm -f ${.CURDIR}/obj; \
		ln -s ${CANONICALOBJDIR} ${.CURDIR}/obj; \
	else \
		echo "No ${CANONICALOBJDIR} to link to - do a make obj."; \
	fi
.endif

.if !target(whereobj)
whereobj:
	@echo ${.OBJDIR}
.endif

cleanobj:
	@if [ -d ${CANONICALOBJDIR}/ ]; then \
		rm -rf ${CANONICALOBJDIR}; \
	else \
		cd ${.CURDIR} && ${MAKE} clean cleandepend; \
	fi
	@if [ -h ${.CURDIR}/obj ]; then rm -f ${.CURDIR}/obj; fi

.if !target(clean)
clean: _SUBDIRUSE
.if defined(CLEANFILES) && !empty(CLEANFILES)
	rm -f ${CLEANFILES}
.endif
.if defined(CLEANDIRS) && !empty(CLEANDIRS)
	rm -rf ${CLEANDIRS}
.endif
.if defined(IMAGES_LIB) && !empty(LOCAL_IMAGES_LIB_DIR)
	rm -rf ${LOCAL_IMAGES_LIB_DIR}
.endif
.endif

cleandir: cleanobj _SUBDIRUSE

.endif # end of NOINCLUDEMK section
