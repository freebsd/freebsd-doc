#!/bin/sh
#
# stage_1.sh - FreeBSD From Scratch, �� 1 �ʳ�: �����ƥ�Υ��󥹥ȡ���
#              �Ȥ���: ./stage_1.sh profile
#              �ɤ߹���ե�����: ./stage_1.conf.profile
#              �񤭽Ф��ե�����: ./stage_1.log.profile
#
# ����:      Jens Schweikhardt
# $Id: stage_1.sh,v 1.2 2006-03-13 16:46:15 rushani Exp $
# $FreeBSD$
# Original revision: 1.5

PATH=/bin:/usr/bin:/sbin:/usr/sbin

# ����Ȥ���Ķ�:
#
# a) "make buildworld" �� "make buildkernel" ������˽�λ���Ƥ��뤳�ȡ�
# b) ̤���ѥѡ��ƥ�����󤬤��뤳�� (�롼�ȥե����륷���ƥ��Ѥ˾��ʤ��Ȥ� 1 �ġ�
#    ���ߤ˱����� /usr �� /var �ѤΤ�Τ��Ѱդ���)
# c) �������ޥ������줿 stage_1.conf.profile �ե����롣

if test $# -ne 1; then
  echo "usage: stage_1.sh profile" 1>&2
  exit 1
fi

# ---------------------------------------------------------------------------- #
# ���ƥå� 1: $DESTDIR �ʲ��˶��Υǥ��쥯�ȥ�ĥ꡼�����
# ---------------------------------------------------------------------------- #

step_one () {
  create_file_systems

  # ������¾�Τ��٤ƤΥǥ��쥯�ȥ�������ɬ�ܡ�
  cd ${SRC}/etc; make distrib-dirs DESTDIR=${DESTDIR}
}

# ---------------------------------------------------------------------------- #
# ���ƥå� 2: /etc �ǥ��쥯�ȥ�ĥ꡼�� / �˥ե�������ɲ�
# ---------------------------------------------------------------------------- #

step_two () {
  copy_files

  # mergemaster �κ�ȥե����뤬����к����
  TEMPROOT=/var/tmp/temproot.stage1
  if test -d ${TEMPROOT}; then
    chflags -R 0 ${TEMPROOT}
    rm -rf ${TEMPROOT}
  fi
  export MAKEDEVPATH="/bin:/sbin:/usr/bin"
  mergemaster -i -m ${SRC}/etc -t ${TEMPROOT} -D ${DESTDIR}
  cap_mkdb ${DESTDIR}/etc/login.conf
  pwd_mkdb -d ${DESTDIR}/etc -p ${DESTDIR}/etc/master.passwd

  # mergemaster �� /var/log ���֤������ե������������ʤ��Τǡ�
  # �����Ǻ����������� copy_files �ǥ��ԡ�����Ƥ�����ϡ������Ȥ���
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
# ���ƥå� 3: installworld ��¹Ԥ���
# ---------------------------------------------------------------------------- #

step_three () {
  cd ${SRC}
  make installworld DESTDIR=${DESTDIR}

  # �ɲäθߴ��饤�֥��򥤥󥹥ȡ��뤹�� (���ץ����)��libc.so.4 ��
  # ưŪ��󥯤���ץ���ब����С��Ĥޤꡢ
  # /usr/libexec/ld-elf.so.1: Shared object "libc.so.4" not found
  # �Ȥ������顼��å����������Ĥ��ä��顢��������Ѥ��뤳�ȡ�
  cd lib/compat/compat4x.i386
  make all install DESTDIR=${DESTDIR}
}

# ---------------------------------------------------------------------------- #
# ���ƥå� 4: �����ͥ�ȥ⥸�塼��򥤥󥹥ȡ��뤹��
# ---------------------------------------------------------------------------- #

step_four () {
  cd ${SRC}
  # installkernel �������åȤˤϡ�loader.conf �� device.hints ��ɬ�ס� 
  # ���ƥå� 2 �ǥ��ԡ����Ƥ��ʤ���С����� 2 �Ԥ�Ȥäƥ��ԡ����뤳�ȡ�
  #   cp sys/boot/forth/loader.conf ${DESTDIR}/boot/defaults
  #   cp sys/i386/conf/GENERIC.hints ${DESTDIR}/boot/device.hints
  make installkernel DESTDIR=${DESTDIR} KERNCONF=${KERNCONF}
}

# ---------------------------------------------------------------------------- #
# ���ƥå� 5: /etc/fstab �ȥ����ॾ�������Υ��󥹥ȡ���
# ---------------------------------------------------------------------------- #

step_five () {
  create_etc_fstab

  # �����ॾ��������ꡣ�ۤȤ�ɤξ���ɬ�ܡ�
  cp ${DESTDIR}/usr/share/zoneinfo/${TIMEZONE} ${DESTDIR}/etc/localtime
  if test -r /etc/wall_cmos_clock; then
    cp -p /etc/wall_cmos_clock ${DESTDIR}/etc/wall_cmos_clock
  fi
}

# ---------------------------------------------------------------------------- #
# ���ƥå� 6: �Ĥ�Υ������ޥ���
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
# ��������¹Գ���
# ---------------------------------------------------------------------------- #

PROFILE="$1"
set -x -e -u # ���顼��ȯ�����뤫̤����ѿ�����Ѥ�������ߤ��롣
. ./stage_1.conf.${PROFILE}

# world �� make ����Τ˻Ȥ�줿�����������ɤ����ѿ��򤤤��Ĥ����ꤹ�롣
# �����ѿ��ϡ����Ȥ��� 4.x �� 5.x �ɤ���Υ����ƥ�򥤥󥹥ȡ��뤹���
# ���Ȥ��ä�ư����ѹ�����Τ˻Ȥ��롣RELDATE ���Ф���
# __FreeBSD_version �� Port �����ԤΤ���Υϥ�ɥ֥å� (Porter's Handbook)
# ����������Ƥ��롣
# doc/en_US.ISO8859-1/books/porters-handbook/freebsd-versions.html
# ���ܸ��Ǥ⤢�뤬���ǿ��ξ���ϱѸ��Ǥ򻲾ȤΤ��ȡ�
# doc/ja_JP.eucJP/books/porters-handbook/freebsd-versions.html
# �����ϡ�<�᥸�㡼�ֹ�><�ޥ��ʡ��ֹ� 2 ��><��꡼���֥����ʤ� 0, ����ʳ��� 1>xx
# ��̤ϼ��Τ褦�ʤ�Τˤʤ롣
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
