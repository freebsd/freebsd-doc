#!/bin/sh
#
# stage_1.sh - FreeBSD From Scratch, Stage 1: System Installation.
#              Usage: ./stage_1.sh profile
#              will read ./stage_1.conf.profile
#              and write ./stage_1.log.profile
#
# Author:      Jens Schweikhardt
# $Id: stage_1.sh,v 1.4 2004-01-21 19:39:26 schweikh Exp $
# $FreeBSD$

PATH=/bin:/usr/bin:/sbin:/usr/sbin

# Prerequisites:
#
# a) Successfully completed "make buildworld" and "make buildkernel"
# b) Unused partitions (at least one for the root fs, probably more for
#    the new /usr and /var, to your liking.)
# c) A customized stage_1.conf.profile file.

if test $# -ne 1; then
  echo "usage: stage_1.sh profile" 1>&2
  exit 1
fi

# ---------------------------------------------------------------------------- #
# Step 1: Create an empty directory tree below $DESTDIR.
# ---------------------------------------------------------------------------- #

step_one () {
  create_file_systems
  # Now create all the other directories. Mandatory.
  cd ${SRC}/etc; make distrib-dirs DESTDIR=${DESTDIR}
}

# ---------------------------------------------------------------------------- #
# Step 2: Fill the empty /etc directory tree and put a few files in /.
# ---------------------------------------------------------------------------- #

step_two () {
  copy_files

  # Delete mergemaster's temproot, if any.
  TEMPROOT=/var/tmp/temproot.stage1
  if test -d ${TEMPROOT}; then
    chflags -R 0 ${TEMPROOT}
    rm -rf ${TEMPROOT}
  fi
  export MAKEDEVPATH="/bin:/sbin:/usr/bin"
  mergemaster -i -m ${SRC}/etc -t ${TEMPROOT} -D ${DESTDIR}
  cap_mkdb ${DESTDIR}/etc/login.conf
  pwd_mkdb -d ${DESTDIR}/etc -p ${DESTDIR}/etc/master.passwd

  # Mergemaster does not create empty files, e.g. in /var/log. Do so now,
  # but do not clobber files that may have been copied with copy_files.
  cd ${TEMPROOT}
  find . -type f | sed 's,^\./,,' |
  while read f; do
    if test -r ${DESTDIR}/${f}; then
      echo "${DESTDIR}/${f} already exists; not copied"
    else
      echo "Creating empty ${DESTDIR}/${f}"
      cp -p ${f} ${DESTDIR}/${f}
    fi
  done
  chflags -R 0 ${TEMPROOT}
  rm -rf ${TEMPROOT}
}

# ---------------------------------------------------------------------------- #
# Step 3: Install world.
# ---------------------------------------------------------------------------- #

step_three () {
  cd ${SRC}
  make installworld DESTDIR=${DESTDIR}
  # Install additional compatibility libraries (optional). Use this if you
  # have programs dynamically linked against libc.so.4, i.e. if you see
  # /usr/libexec/ld-elf.so.1: Shared object "libc.so.4" not found
  cd lib/compat/compat4x.i386
  make all install DESTDIR=${DESTDIR}
}

# ---------------------------------------------------------------------------- #
# Step 4: Install kernel and modules.
# ---------------------------------------------------------------------------- #

step_four () {
  cd ${SRC}
  # The loader.conf and device.hints are required by the installkernel target.
  # If you have not copied them in Step 2, cp them as shown in the next 2 lines.
  #   cp sys/boot/forth/loader.conf ${DESTDIR}/boot/defaults
  #   cp sys/i386/conf/GENERIC.hints ${DESTDIR}/boot/device.hints
  make installkernel DESTDIR=${DESTDIR} KERNCONF=${KERNCONF}
}

# ---------------------------------------------------------------------------- #
# Step 5: Install /etc/fstab and time zone info.
# ---------------------------------------------------------------------------- #

step_five () {
  create_etc_fstab

  # Setup time zone info; pretty much mandatory.
  cp ${DESTDIR}/usr/share/zoneinfo/${TIMEZONE} ${DESTDIR}/etc/localtime
  if test -r /etc/wall_cmos_clock; then
     cp -p /etc/wall_cmos_clock ${DESTDIR}/etc/wall_cmos_clock
  fi
}

# ---------------------------------------------------------------------------- #
# Step 6: All remaining customization.
# ---------------------------------------------------------------------------- #

step_six () {
  all_remaining_customization
}

do_steps () {
  echo "PROFILE=${PROFILE}"
  echo "DESTDIR=${DESTDIR}"
  echo "SRC=${SRC}"
  echo "KERNCONF=${KERNCONF}"
  echo "TIMEZONE=${TIMEZONE}"
  echo "TYPE=${TYPE}"
  echo "REVISION=${REVISION}"
  echo "BRANCH=${BRANCH}"
  echo "RELDATE=${RELDATE}"
  step_one
  step_two
  step_three
  step_four
  step_five
  step_six
}

# ---------------------------------------------------------------------------- #
# The ball starts rolling here.
# ---------------------------------------------------------------------------- #

PROFILE="$1"
set -x -e -u # Stop for any error or use of an undefined variable.
. ./stage_1.conf.${PROFILE}

# Determine a few variables from the sources that were used to make the
# world. The variables can be used to modify actions, e.g. depending on
# whether we install a 4.x or 5.x system. The __FreeBSD_version numbers
# for RELDATE are documented in the Porter's Handbook,
# doc/en_US.ISO8859-1/books/porters-handbook/freebsd-versions.html.
# Scheme is:  <major><two digit minor><0 if release branch, otherwise 1>xx
# The result will be something like
#
#   TYPE="FreeBSD"
#   REVISION="4.9"
#   BRANCH="RC"      { "CURRENT", "STABLE", "RELEASE" }
#   RELDATE="502101"
#
eval $(awk '/^(TYPE|REVISION|BRANCH)=/' ${SRC}/sys/conf/newvers.sh)
RELDATE=$(awk '/^[ \t]*#[ \t]*define[ \t][ \t]*__FreeBSD_version[ \t]/ {
                print $3
              }' ${SRC}/sys/sys/param.h)

echo "=> Logging to stage_1.log.${PROFILE}"
do_steps 2>&1 | tee stage_1.log.${PROFILE}

# vim: tabstop=2:expandtab:shiftwidth=2:
# EOF $RCSfile: stage_1.sh,v $
