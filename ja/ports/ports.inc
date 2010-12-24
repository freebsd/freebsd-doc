<!-- $FreeBSD: www/ja/ports/ports.inc,v 1.24 2003/10/12 10:52:33 rushani Exp $ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.67 -->
<p>FreeBSD Ports/Packages Collection は、
ユーザや管理者がアプリケーションのインストールを簡単に行なえる方法を提供します。
Ports Collection は<a
href="../../ports/growth/status.png">驚異的な速度で
その数を増してきました</a>。
</p>

<p>Ports Collection は FreeBSD-CURRENT ブランチと
FreeBSD-STABLE ブランチの最新のリリースに対応しています。
それより古いリリースには対応しておらず、先端の Ports Collection は
正しく動作するかもしれませんし、しないかもしれません。
時間の経過とともに、過去のリリースには存在しない機能を必要とする変更が
Ports Collection に加えられるかもしれません。どんな環境でも利用できるように、
最近のリリースでの対応を理由なく取り止めることはないように努めていますが、
やむをえないときもあります。なお、古いリリースを保守するためのパッチが
ユーザコミュニティから寄贈された場合は採用されるでしょう。</p>

<p>ここに並べられている各 ``port'' には、
FreeBSD 上でオリジナルのアプリケーションのソースコードをコンパイルし、
実行するために必要なパッチがすべて含まれています。
アプリケーションのインストールは簡単で、port をダウンロードし、
それを展開し、その port のディレクトリで <tt>make</tt> と打つだけです。
より便利にするためには、インストール時に
<a href="ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/ports/ports.tar.gz">
ports 階層全体</a> をインストール
(あるいは 
<a href="../../doc/ja_JP.eucJP/books/handbook/synching.html#CVSUP">CVSup</a>
を使ってこれらを最新のものに更新)
してください。何千ものアプリケーションが、すぐに使えるようになります。

各 ports の <tt>Makefile</tt>は自動的に、ローカルディスクや CDROM、ftp 経由で
アプリケーションのソースコードを取ってきて、
あなたのシステム上で展開し、パッチをあて、
コンパイルします。
問題がないようなら、あとは <tt>make install</tt>
とするだけでアプリケーションをインストールして
パッケージシステムへ登録できます。</p>

<p>ほとんどの ports には、すべてをコンパイルする時間を節約できる、
あらかじめコンパイルされた <tt>package</tt> もあります。
それぞれの port には対応する package へのリンクがありますので、
そのファイルをダウンロードして <strong>pkg_add</strong> コマンドを
実行することもできますし、また <strong>pkg_add</strong> ではファイル名
と同じく FTP URL を使うこともできるのでリンク先を <strong>pkg_add</strong>
することもできます。</p>

<p>ports/packages の追加、更新、削除についての情報や、
どのアプリケーションが
ports/packages となっているかの検索は
<a href="http://www.FreeBSD.org/cgi/ports.cgi">
FreeBSD ports の更新情報</a> ページを参照してください。</p>

<FORM METHOD="GET" ACTION="http://www.FreeBSD.org/cgi/ports.cgi">
検索:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">すべて</OPTION>
<OPTION VALUE="name">package 名</OPTION>
<OPTION VALUE="text">詳細</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="検索">
</FORM>

<p>ports についてもう少し詳しく知りたい場合には、
<a href="../../doc/ja_JP.eucJP/books/handbook/">FreeBSD ハンドブック</a> にある
<a href="../../doc/ja_JP.eucJP/books/handbook/ports.html">アプリケーションのインストール: Ports Collection</a>
を、また、新しい ports を作るための情報は
<a href="../../doc/ja_JP.eucJP/books/porters-handbook/index.html">port 作成者のためのハンドブック</a>
を参照してください。</p>
