<!-- $FreeBSD: www/ja/ports/ports.inc,v 1.17 2001/04/03 17:18:36 hrs Exp $ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.56 -->
<p>FreeBSD Ports/Packages Collection は,
ユーザや管理者がアプリケーションのインストールを簡単に行なえる方法を提供します.
Ports Collection は<a
href="http://www.freebsd.org/%7Easami/papers/growth.gif">驚異的な速度で
その数を増してきました</a>.
</p>

<p>ここに並べられている各 ``port'' には,
FreeBSD 上でオリジナルのアプリケーションのソースコードをコンパイルし,
実行するために必要なパッチがすべて含まれています.
アプリケーションのインストールは簡単で, port をダウンロードし,
それを展開し, その port のディレクトリで <tt>make</tt> と打つだけです.
より便利にするためには, インストール時に
<a href="ftp://ftp5.freebsd.org/pub/FreeBSD/branches/-current/ports.tar.gz">
ports 階層全体</a> をインストール
(あるいは 
<a href="../handbook/synching.html#CVSUP">CVSup</a>
を使ってこれらを最新のものに更新)
してください. 何千ものアプリケーションが, すぐに使えるようになります.

各 ports の <tt>Makefile</tt>は自動的に, ローカルディスクや CDROM, ftp 経由で
アプリケーションのソースコードを取ってきて,
あなたのシステム上で展開し, パッチをあて, 
コンパイルします. 
問題がないようなら, あとは <tt>make install</tt>
とするだけでアプリケーションをインストールして
パッケージシステムへ登録できます. </p>

<p>ほとんどの ports には, すべてをコンパイルする時間を節約できる,
あらかじめコンパイルされた <tt>package</tt> もあります.
それぞれの port には対応する package へのリンクがありますので,
そのファイルをダウンロードして <strong>pkg_add</strong> コマンドを
実行することもできますし, また <strong>pkg_add</strong> ではファイル名
と同じく FTP URL を使うこともできるのでリンク先を <strong>pkg_add</strong>
することもできます.</p>

<p>ports/packages の追加, 更新, 削除についての情報や,
どのアプリケーションが
ports/packages となっているかの検索は
<a href="http://www.freebsd.org/cgi/ports.cgi">
FreeBSD ports の更新情報</a> ページを参照してください. </p>

<FORM METHOD="GET" ACTION="http://www.freebsd.org/cgi/ports.cgi">
検索:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">すべて</OPTION>
<OPTION VALUE="name">パッケージ名</OPTION>
<OPTION VALUE="text">詳細</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="検索">
</FORM>

<p>ports についてもう少し詳しく知りたい場合には, 
<a href="../handbook/">FreeBSD ハンドブック</a> にある
<a href="../handbook/ports.html">Ports Collection</a>
を, また, 新しい ports を作るための情報は
<a href="../porters-handbook/">アプリケーションの移植</a> を参照
してください. </p>

<hr>

<H1 ALIGN="LEFT"><FONT COLOR="#660000">アップグレードキット</FONT></H1>

<p>
これらの web ページにリストされている ports は常に更新され続けています.
多くの ports は ports ツリーの他の部分に依存しますので, コレクション
全体を同時に更新することをお勧めします. もしそれができないなら, 
少なくとも <tt>ports/Mk</tt> にある make マクロが最新のものであることを
確認してください. (つまり, あなたが <strong>cvsup</strong> を使って
いるのなら, <tt>ports-base</tt> が cvsupfile の中に必要だということです.)
<tt>bsd.port.mk</tt> その他が最新でもまだエラーが出るなら, 
すみませんがコレクション全体を入手してください. 
</p>

<p>
最新の ports ツリーは FreeBSD-current と FreeBSD-stable だけを
公式にサポートします.
したがって, あなたが使っているバージョンの FreeBSD のリリース以降に
開発された ports を使うためには FreeBSD システムのいくつかのファイルを
更新する必要があるかもしれません.
以下のリストの中から, あなたが使っているリリースにあったものをインストール
してください.
もしあなたのシステムが以下の packages リストにあるものより新しいなら,
更新用 packges は必要ありません. もしあなたのシステムが 4.1-RELEASE
より古かったり, 4.1 より古いブランチを使っているなら, ports-current
を使うためには 4.x ブランチの (訳注: 4.1 以降の) 適当な時点まで
アップグレードしてください. それが唯一の合理的な選択肢です. 
</p>

<dl>
<dt><a
href="ftp://ftp5.freebsd.org/pub/FreeBSD/ports/i386/packages-4-stable/Latest/41upgrade.tgz">4.1
から 4-STABLE へのアップグレードキット</a>
<dd>4.1-RELEASE ユーザもしくは 2000 年 7 月 27 日から 2000 年 10 月 31 日
の間の 4.1-STABLE ユーザ用
<dt><a
href="ftp://ftp5.freebsd.org/pub/FreeBSD/ports/i386/packages-4-stable/Latest/42upgrade.tgz">4.2
から 4-STABLE へのアップグレードキット</a>
<dd>4.2-RELEASE ユーザもしくは 2000 年 10 月 31 日から 2001 年 1 月 8 日
の間の 4.x-STABLE もしくは 4.2-BETA もしくは 4.2-RC ユーザ用
</dl>

<p>
これらは FreeBSD のパッケージになっています. インストールには
<strong>pkg_add</strong> を使ってください.
これでここに載っている全ての ports を使うことができるようになります. 
このアップグレードキットは ports やパッケージを使うのに必要なファイル
だけを更新します. -STABLE への完全なアップグレードについては,
ハンドブックの<a href="../handbook/synching.html">
インターネットを通じたソースツリーの同期</a>を参照してください. 

2.2.X ブランチおよび 3.X ブランチは ports-current では公式にはサポート
されていません. 過去のリリースといっしょに配布された ports ツリーは
多分うまく動くでしょうが, これも ports team はサポートしません. なぜなら
ports-current を十分にサポートするだけですでに時間がいっぱいだからです. 
</p>

<p>多くの ports はコンパイルと実行に X Window System を必要とします. 
ports は <a href="http://www.xfree86.org/">XFree86</a> 上でテ
ストされています. 最新のリリースは 3.3.6 です. いくつかの ports は
これ以外のリリースでは動作しないかも知れません. </p>
