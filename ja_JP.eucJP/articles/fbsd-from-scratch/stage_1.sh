#!/bin/sh
#
# stage_1.sh - FreeBSD From Scratch, 第 1 段階: システムのインストール
#              使い方: ./stage_1.sh
#
# $FreeBSD$
# Original revision: 1.1

set -x -e
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# 前提とする環境:
#
# a) "make buildworld" と "make buildkernel" が正常に終了していること。
# b) 未使用パーティションがあること (ルートファイルシステム用に少なくとも 1 個、
#    好みに応じて /usr や /var 用のものを用意する)

# 新しいシステムを作成する場所を示すルートマウントポイントを指定。
# マウントポイントとして使われるだけなので、マウントポイントのある
# ファイルシステムにファイルは置かれず、書き込みはすべてマウントした
# ファイルシステムに行なわれる。
DESTDIR=/newroot
SRC=/usr/src         # src ツリーのある場所

# ---------------------------------------------------------------------------- #
# ステップ 1: $DESTDIR 以下に空のディレクトリツリーを作成
# ---------------------------------------------------------------------------- #

step_one () {
  # 新しいルートファイルシステムを作成する。必須。
  # デバイス名 (DEV_*) を変更すること。変更しないとシステムが壊れる危険性がある。
  DEV_ROOT=/dev/da3s1a
  mkdir -p ${DESTDIR}
  newfs ${DEV_ROOT}
  tunefs -n enable ${DEV_ROOT}
  mount -o noatime ${DEV_ROOT} ${DESTDIR}

  # その他のファイルシステムと初期マウントポイント。オプション。
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

  # ここで他のすべてのディレクトリを作成。必須。
  cd ${SRC}/etc; make distrib-dirs DESTDIR=${DESTDIR}
  # 個人的には tmp -> var/tmp とシンボリックリンクを張るのが好み。オプション。
  cd ${DESTDIR}; rmdir tmp; ln -s var/tmp
}

# ---------------------------------------------------------------------------- #
# ステップ 2: /etc ディレクトリツリーと / にファイルを追加
# ---------------------------------------------------------------------------- #

step_two () {
  # 好みに応じて、このリストに追加・削除すること。ほとんどの場合は必須。
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
  # mergemaster の作業ファイルがあれば削除。
  TEMPROOT=/var/tmp/temproot.stage1
  if test -d ${TEMPROOT}; then
    chflags -R 0 ${TEMPROOT}
    rm -rf ${TEMPROOT}
  fi
  mergemaster -i -m ${SRC}/etc -t ${TEMPROOT} -D ${DESTDIR}
  cap_mkdb ${DESTDIR}/etc/login.conf
  pwd_mkdb -d ${DESTDIR}/etc -p ${DESTDIR}/etc/master.passwd

  # mergemaster は /var/log に置かれる空ファイルを作成しないので、
  # ここで作成。ただし上のループでコピーされている場合は、それを使う。
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
# ステップ 3: installworld を実行する
# ---------------------------------------------------------------------------- #

step_three () {
  cd ${SRC}
  make installworld DESTDIR=${DESTDIR}
}

# ---------------------------------------------------------------------------- #
# ステップ 4: カーネルとモジュールをインストールする
# ---------------------------------------------------------------------------- #

step_four () {
  cd ${SRC}
  # installkernel ターゲットには、loader.conf と device.hints が必要。 
  # ステップ 2 でコピーしていなければ、次の 2 行を使ってコピーすること。
  #   cp sys/boot/forth/loader.conf ${DESTDIR}/boot/defaults
  #   cp sys/i386/conf/GENERIC.hints ${DESTDIR}/boot/device.hints
  make installkernel DESTDIR=${DESTDIR} KERNCONF=HAL9000
}

# ---------------------------------------------------------------------------- #
# ステップ 5: 必須のファイルのインストールと変更
# ---------------------------------------------------------------------------- #

step_five () {
  # /etc/fstab の作成。必須。自分のデバイスに合うように変更すること。
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

  # その他のディレクトリ。オプション。
  mkdir -m 755 -p ${DESTDIR}/src;       chown root:wheel ${DESTDIR}/src
  mkdir -m 755 -p ${DESTDIR}/share;     chown root:wheel ${DESTDIR}/share
  mkdir -m 755 -p ${DESTDIR}/dvd;       chown root:wheel ${DESTDIR}/dvd
  mkdir -m 755 -p ${DESTDIR}/home;      chown root:wheel ${DESTDIR}/home
  mkdir -m 755 -p ${DESTDIR}/usr/ports; chown root:wheel ${DESTDIR}/usr/ports
  # タイムゾーンの設定。ほとんどの場合は必須。
  cp ${DESTDIR}/usr/share/zoneinfo/Europe/Berlin ${DESTDIR}/etc/localtime
  if test -r /etc/wall_cmos_clock; then
     cp -p /etc/wall_cmos_clock ${DESTDIR}/etc/wall_cmos_clock
  fi
}

# ---------------------------------------------------------------------------- #
# ステップ 6: 新しいシステムにログインする時に重要な内容
# 注意: あまり多くのバイナリをこの時点でインストールしないこと。稼働している
# 古いシステムと、インストールした新しいバイナリ・ヘッダを組み合わせると、
# ブートストラップ問題に陥る可能性がある。ports は新しいシステムが起動した後に
# 再構築する方がよい。
# ---------------------------------------------------------------------------- #

step_six () {
  chroot ${DESTDIR} sh -c "cd /usr/ports/shells/zsh; make clean install clean"
  chroot ${DESTDIR} sh -c "cd /etc/mail; make install"  # configure sendmail

  # compat シンボリックリンクがないと、linux_base のファイル群が
  # ルートファイルシステムに置かれてしまう。
  cd ${DESTDIR}; mkdir -m 755 usr/compat
  chown root:wheel usr/compat; ln -s usr/compat
  mkdir -m 755 usr/compat/linux
  mkdir -m 755 boot/grub

  # /etc/printcap で指定したスプールディレクトリを作成。
  cd ${DESTDIR}/var/spool/output/lpd; mkdir -p as od ev te lp da
  touch ${DESTDIR}/var/log/lpd-errs

  # 古いシステムから引き継ぎたいファイルを指定
  for f in \
    /var/cron/tabs/root \
    /var/mail/* \
    /boot/grub/*; do
    cp -p ${f} ${DESTDIR}${f}
  done

  # 共有パーティション /home がなければ、/home をコピーした方がよいかも知れない。
  # mkdir -p ${DESTDIR}/home
  # cd /home; tar cf - . | (cd ${DESTDIR}/home; tar xpvf -)

  # FreeBSD 5.x より perl は /usr/local/bin に置かれるようになったが、
  # 多くのスクリプトは #!/usr/bin/perl でハードコードされている。
  # これらを動作させるため、シンボリックリンクを作成しておく。
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
