#!/bin/sh
#
# stage_1.sh - FreeBSD From Scratch, Stage 1: System Installation.
#              Usage: ./stage_1.sh
#
# $FreeBSD$

set -x -e
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# Prerequisites:
#
# a) Successfully completed "make buildworld" and "make buildkernel"
# b) Unused partitions (at least one for the root fs, probably more for
#    the new /usr and /var, to your liking.)

# Root mount point where you create the new system. Because it is only
# used as a mount point, no space will be used on that file system as all
# files are of course written to the mounted file system(s).
DESTDIR=/newroot
SRC=/usr/src         # Where your src tree is.

# ---------------------------------------------------------------------------- #
# Step 1: Create an empty directory tree below $DESTDIR.
# ---------------------------------------------------------------------------- #

step_one () {
  # The new root file system. Mandatory.
  # Change device names (DEV_*) or risk foot shooting.
  DEV_ROOT=/dev/da3s1a
  mkdir -p ${DESTDIR}
  newfs ${DEV_ROOT}
  tunefs -n enable ${DEV_ROOT}
  mount -o noatime ${DEV_ROOT} ${DESTDIR}

  # Additional file systems and initial mount points. Optional.
  DEV_VAR=/dev/vinum/var_a
  newfs ${DEV_VAR}
  tunefs -n enable ${DEV_VAR}
  mkdir -m 755 ${DESTDIR}/var
  mount -o noatime ${DEV_VAR} ${DESTDIR}/var

  DEV_USR=/dev/vinum/usr_a
  newfs ${DEV_USR}
  tunefs -n enable ${DEV_USR}
  mkdir -m 755 ${DESTDIR}/usr
  mount -o noatime ${DEV_USR} ${DESTDIR}/usr

  mkdir -m 755 -p ${DESTDIR}/usr/ports
  mount /dev/vinum/ports ${DESTDIR}/usr/ports

  # Now create all the other directories. Mandatory.
  cd ${SRC}/etc; make distrib-dirs DESTDIR=${DESTDIR}
  # My personal preference is to symlink tmp -> var/tmp. Optional.
  cd ${DESTDIR}; rmdir tmp; ln -s var/tmp
}

# ---------------------------------------------------------------------------- #
# Step 2: Fill the empty /etc directory tree and put a few files in /.
# ---------------------------------------------------------------------------- #

step_two () {
  # Add or remove from this list at your discretion. Mostly mandatory.
  for f in \
    /.profile \
    /etc/group \
    /etc/hosts \
    /etc/inetd.conf \
    /etc/ipfw.conf \
    /etc/make.conf \
    /etc/master.passwd \
    /etc/nsswitch.conf \
    /etc/ntp.conf \
    /etc/printcap \
    /etc/profile \
    /etc/rc.conf \
    /etc/resolv.conf \
    /etc/start_if.xl0 \
    /etc/ttys \
    /etc/ppp/* \
    /etc/mail/aliases \
    /etc/mail/aliases.db \
    /etc/mail/hal9000.mc \
    /etc/mail/service.switch \
    /etc/ssh/*key* \
    /etc/ssh/*_config \
    /etc/X11/XF86Config-4 \
    /boot/splash.bmp \
    /boot/loader.conf \
    /boot/device.hints ; do
    cp -p ${f} ${DESTDIR}${f}
  done
  # Delete mergemaster's temproot, if any.
  TEMPROOT=/var/tmp/temproot.stage1
  if test -d ${TEMPROOT}; then
    chflags -R 0 ${TEMPROOT}
    rm -rf ${TEMPROOT}
  fi
  mergemaster -i -m ${SRC}/etc -t ${TEMPROOT} -D ${DESTDIR}
  cap_mkdb ${DESTDIR}/etc/login.conf
  pwd_mkdb -d ${DESTDIR}/etc -p ${DESTDIR}/etc/master.passwd

  # Mergemaster does not create empty files, e.g. in /var/log. Do so now,
  # but do not clobber files that may have been copied in the loop above.
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
  make installkernel DESTDIR=${DESTDIR} KERNCONF=HAL9000
}

# ---------------------------------------------------------------------------- #
# Step 5: Install or modify a few essential files.
# ---------------------------------------------------------------------------- #

step_five () {
  # Create /etc/fstab; mandatory. Modify to match your devices.
  cat <<EOF >${DESTDIR}/etc/fstab
# Device         Mountpoint          FStype    Options              Dump Pass#
/dev/da3s1b      none                swap      sw                   0    0
/dev/da4s2b      none                swap      sw                   0    0
/dev/da3s1a      /                   ufs       rw                   1    1
/dev/da1s2a      /src                ufs       rw                   0    2
/dev/da2s2f      /share              ufs       rw                   0    2
/dev/vinum/var_a /var                ufs       rw                   0    2
/dev/vinum/usr_a /usr                ufs       rw                   0    2
/dev/vinum/home  /home               ufs       rw                   0    2
/dev/vinum/ncvs  /home/ncvs          ufs       rw,noatime           0    2
/dev/vinum/ports /usr/ports          ufs       rw,noatime           0    2
#
/dev/cd0         /dvd                cd9660    ro,noauto            0    0
/dev/cd1         /cdrom              cd9660    ro,noauto            0    0
proc             /proc               procfs    rw                   0    0
EOF

  # More directories; optional.
  mkdir -m 755 -p ${DESTDIR}/src;       chown root:wheel ${DESTDIR}/src
  mkdir -m 755 -p ${DESTDIR}/share;     chown root:wheel ${DESTDIR}/share
  mkdir -m 755 -p ${DESTDIR}/dvd;       chown root:wheel ${DESTDIR}/dvd
  mkdir -m 755 -p ${DESTDIR}/home;      chown root:wheel ${DESTDIR}/home
  mkdir -m 755 -p ${DESTDIR}/usr/ports; chown root:wheel ${DESTDIR}/usr/ports
  # Setup time zone info; pretty much mandatory.
  cp ${DESTDIR}/usr/share/zoneinfo/Europe/Berlin ${DESTDIR}/etc/localtime
  if test -r /etc/wall_cmos_clock; then
     cp -p /etc/wall_cmos_clock ${DESTDIR}/etc/wall_cmos_clock
  fi
}

# ---------------------------------------------------------------------------- #
# Step 6: Things important to me when I first login to a new system.
# NOTE: Do not install too many binaries here. With the old system running and
# the new binaries and headers installed you are likely to run into bootstrap
# problems. Ports should be compiled after you have booted in the new system.
# ---------------------------------------------------------------------------- #

step_six () {
  chroot ${DESTDIR} sh -c "cd /usr/ports/shells/zsh; make clean install clean"
  chroot ${DESTDIR} sh -c "cd /etc/mail; make install"  # configure sendmail

  # Without the compat symlink the linux_base files end up on the root fs:
  cd ${DESTDIR}; mkdir -m 755 usr/compat
  chown root:wheel usr/compat; ln -s usr/compat
  mkdir -m 755 usr/compat/linux
  mkdir -m 755 boot/grub

  # Make spooldirs for the printers in my /etc/printcap.
  cd ${DESTDIR}/var/spool/output/lpd; mkdir -p as od ev te lp da
  touch ${DESTDIR}/var/log/lpd-errs

  # More files I want to inherit from the old system.
  for f in \
    /var/cron/tabs/root \
    /var/mail/* \
    /boot/grub/*; do
    cp -p ${f} ${DESTDIR}${f}
  done

  # If you do not have /home on a shared partition, you may want to copy it:
  # mkdir -p ${DESTDIR}/home
  # cd /home; tar cf - . | (cd ${DESTDIR}/home; tar xpvf -)

  # Starting with FreeBSD 5.x, perl lives in /usr/local/bin but many scripts
  # use a hardcoded #!/usr/bin/perl; use a symlink to make them work.
  cd ${DESTDIR}/usr/bin; ln -s ../local/bin/perl
  cd ${DESTDIR}/usr; rmdir src; ln -s ../src/current src
}

do_steps () {
  step_one
  step_two
  step_three
  step_four
  step_five
  step_six
}

do_steps 2>&1 | tee stage_1.log

# EOF $RCSfile: stage_1.sh,v $    vim: tabstop=2:expandtab:
