<!-- $FreeBSD$ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.35 -->
<p>FreeBSD の Ports と Packages のコレクションは,
ユーザや管理者が簡単にアプリケーショ
ンのインストールを簡単に行う方法を提供します.
ports コレクションは<a
href="http://www.freebsd.org/%7Easami/papers/growth.gif">驚異的な速度で
その数を増してきました</a>.

<p>ここに並べられている各 ``port'' には, FreeBSD でオリジナルのアプリケー
ションのソースコードをコンパイルし実行するために必要なパッチが全て含ま
れています.
アプリケーションのインストールは簡単で, port をダウンロードし, それを
展開し, port ディレクトリで <tt>make</tt> と打つだけです.
より便利にするためには, インストール時に
<a href="ftp://ftp.freebsd.org/pub/FreeBSD/branches/-current/ports.tar.gz">
ports 階層全体</a> をインストール (あるいは 
<a href="../handbook/synching.html#CVSUP">CVSup</a> を使ってこれらを最新のものに
更新) すれば, 何千ものアプリケーションがすぐに使えるようになります.

各 ports の <tt>Makefile</tt>は自動的に, ローカルディスクや CDROM, ftp 経由で
アプリケーションのソースコードを取ってきて,
あなたのシステム上で展開し, パッチをあて, 
コンパイルします. 
問題がないようなら, あとは<tt>make install</tt>とするだけでアプリケー
ションをインストールして package システムへ登録できます. </p>

<p>ほとんどの ports には, あらかじめコンパイルされた <tt>package</tt>
もあるので, すべてをコンパイルする時間を節約することができます.
それぞれの port には対応する package へのリンクがあるので,
そのファイルをダウンロードして <strong>pkg_add</strong> コマンドを
実行することもできますし, また <strong>pkg_add</strong> ではファイル名
と同じく FTP URL を使うこともできるのでリンク先を <strong>pkg_add</strong>
することもできます.</p>

<p>ports についてもう少し詳しく知りたい場合には, 
<a href="../handbook/ports.html">ports コレクション</a> を参照してくだ
さい. 新しい ports を作るには, 
<a href="../handbook/porting.html">フリーソフトウェアの移植</a> を参照
してください. どちらも <a href="../handbook">FreeBSD ハンドブック</a> 
の一部です.</p>

<p>これらの web ページにリストされている ports は常に更新され続けています.
まず最初に, あなたが使っているバージョンの FreeBSD のリリース以降に
開発された ports を使うためには FreeBSD システムのいくつかのファイルを
更新する必要があるかもしれません.
以下のリストの中から, あなたが使っている release にあったものをインストール
してください.
ここ数日のものより以前の FreeBSD-stable や FreeBSD-current を使っている
場合にも, 適切なアップグレードキットをインストールするのをお勧めします.
ports システムは時により非常に速く変更されます.

<dl>
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/221upgrade.tgz">2.2.1
から 2.2-stable へのアップグレードキット</a>
<dd>2.2.1-release もしくは 2.2.1-release から 2.2.2-release の間の 2.2-stable
ユーザ用
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/222upgrade.tgz">2.2.2
から 2.2-stable へのアップグレードキット</a>
<dd>2.2.2-release もしくは 
2.2.2-release から 2.2.5-release の間の 2.2-stable ユーザ用
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/225upgrade.tgz">2.2.5
から 2.2-stable へのアップグレードキット</a>
<dd>2.2.5-release もしくは
2.2.5-release から 2.2.6-release の間の 2.2-stable ユーザ用
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/227upgrade.tgz">2.2.7
から 2.2-stable へのアップグレードキット</a>
<dd>2.2.6-release, 2.2.7-release, 2.2.8-release もしくは
2.2.6-release 以降の 2.2-stable ユーザ用
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-3-stable/Latest/30upgrade.tgz">3.0
から 3.1-stable へのアップグレードキット</a>
<dd>3.0-release もしくは 3.0-release 以降の 3.0-stable ユーザ用
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-3-stable/Latest/31upgrade.tgz">3.1
から 3.1-stable へのアップグレードキット</a>
<dd>3.1-release もしくは 3.1-release 以降の 3.1-stable ユーザ用
</dl>

<p>これらは FreeBSD のパッケージになっています. インストールには
<strong>pkg_add</strong> を使ってください.
これでここに載っている全ての ports を使うことができるようになります. 
このアップグレードキットは ports やパッケージを使うのに必要なファイル
だけを更新します. 3.1-stable への完全なアップグレードについては,
ハンドブックの<a href="../handbook/synching.html">
インターネットを通じたソースツリーの同期</a>を参照してください. 
完全なアップグレードが (まだ 2.2.7-release より前のバージョンを使っている
場合は特に)推奨されています.
さらに, 2.2.X 系列は現在 ports-current では公式にはサポートされていません.
ここにリストされている ports を使う場合は, たとえあなたの 2.2.X システムの
リリースに含まれているものであっても, ``自分の責任で'' 行なってください.</p>

<p>多くの ports はコンパイルと実行に X Window System を必要とします. 
ports は <a href="http://www.xfree86.org/">XFree86</a> 上でテ
ストされています. 最新のリリースは 3.3.3.1 です. いくつかの ports は古い
リリースでは動作しないかも知れません. </p>

<p>ports/packages の追加, 更新, 削除についての情報や, アプリケーションが
ports/packages となっているかの検索は
<a href="http://www.freebsd.org/cgi/ports.cgi">
FreeBSD Ports 更新</a> ページを参照してください. </p>

<FORM METHOD="GET" ACTION="http://www.freebsd.org/cgi/ports.cgi">
検索:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">全て</OPTION>
<OPTION VALUE="name">パッケージ名</OPTION>
<OPTION VALUE="text">詳細</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="Submit">
</FORM>
