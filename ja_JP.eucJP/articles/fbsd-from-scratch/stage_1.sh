#!/bin/sh
#
# stage_1.sh - FreeBSD From Scratch, 第 1 段階: システムのインストール
#              使い方: ./stage_1.sh profile
#              読み込むファイル: ./stage_1.conf.profile
#              書き出すファイル: ./stage_1.log.profile
#
# 著者:      Jens Schweikhardt
# $Id: stage_1.sh,v 1.2 2006-03-13 16:46:15 rushani Exp $
# $FreeBSD$
# Original revision: 1.5

PATH=/bin:/usr/bin:/sbin:/usr/sbin

# 前提とする環境:
#
# a) "make buildworld" と "make buildkernel" が正常に終了していること。
# b) 未使用パーティションがあること (ルートファイルシステム用に少なくとも 1 個、
#    好みに応じて /usr や /var 用のものを用意する)
# c) カスタマイズされた stage_1.conf.profile ファイル。

if test $# -ne 1; then
  echo "usage: stage_1.sh profile" 1>&2
  exit 1
fi

# ---------------------------------------------------------------------------- #
# ステップ 1: $DESTDIR 以下に空のディレクトリツリーを作成
# ---------------------------------------------------------------------------- #

step_one () {
  create_file_systems

  # ここで他のすべてのディレクトリを作成。必須。
  cd ${SRC}/etc; make distrib-dirs DESTDIR=${DESTDIR}
}

# ---------------------------------------------------------------------------- #
# ステップ 2: /etc ディレクトリツリーと / にファイルを追加
# ---------------------------------------------------------------------------- #

step_two () {
  copy_files

  # mergemaster の作業ファイルがあれば削除。
  TEMPROOT=/var/tmp/temproot.stage1
  if test -d ${TEMPROOT}; then
    chflags -R 0 ${TEMPROOT}
    rm -rf ${TEMPROOT}
  fi
  export MAKEDEVPATH="/bin:/sbin:/usr/bin"
  mergemaster -i -m ${SRC}/etc -t ${TEMPROOT} -D ${DESTDIR}
  cap_mkdb ${DESTDIR}/etc/login.conf
  pwd_mkdb -d ${DESTDIR}/etc -p ${DESTDIR}/etc/master.passwd

  # mergemaster は /var/log に置かれる空ファイルを作成しないので、
  # ここで作成。ただし copy_files でコピーされている場合は、それを使う。
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

  # 追加の互換ライブラリをインストールする (オプション)。libc.so.4 を
  # 動的リンクするプログラムがあれば、つまり、
  # /usr/libexec/ld-elf.so.1: Shared object "libc.so.4" not found
  # というエラーメッセージが見つかったら、これを利用すること。
  cd lib/compat/compat4x.i386
  make all install DESTDIR=${DESTDIR}
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
  make installkernel DESTDIR=${DESTDIR} KERNCONF=${KERNCONF}
}

# ---------------------------------------------------------------------------- #
# ステップ 5: /etc/fstab とタイムゾーン情報のインストール
# ---------------------------------------------------------------------------- #

step_five () {
  create_etc_fstab

  # タイムゾーンの設定。ほとんどの場合は必須。
  cp ${DESTDIR}/usr/share/zoneinfo/${TIMEZONE} ${DESTDIR}/etc/localtime
  if test -r /etc/wall_cmos_clock; then
    cp -p /etc/wall_cmos_clock ${DESTDIR}/etc/wall_cmos_clock
  fi
}

# ---------------------------------------------------------------------------- #
# ステップ 6: 残りのカスタマイズ
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
# ここから実行開始
# ---------------------------------------------------------------------------- #

PROFILE="$1"
set -x -e -u # エラーが発生するか未定義変数を使用したら停止する。
. ./stage_1.conf.${PROFILE}

# world を make するのに使われたソースコードから変数をいくつか決定する。
# この変数は、たとえば 4.x と 5.x どちらのシステムをインストールするの
# かといった動作を変更するのに使われる。RELDATE に対する
# __FreeBSD_version は Port 作成者のためのハンドブック (Porter's Handbook)
# で説明されている。
# doc/en_US.ISO8859-1/books/porters-handbook/freebsd-versions.html
# 日本語版もあるが、最新の情報は英語版を参照のこと。
# doc/ja_JP.eucJP/books/porters-handbook/freebsd-versions.html
# 形式は、<メジャー番号><マイナー番号 2 桁><リリースブランチなら 0, それ以外は 1>xx
# 結果は次のようなものになる。
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
