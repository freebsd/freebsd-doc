<!-- $FreeBSD: www/ja/ports/ports.inc,v 1.25 2010/12/24 12:24:49 ryusuke Exp $ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.69 -->
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
それを展開し、その port のディレクトリで
<a href="http://www.freebsd.org/cgi/man.cgi?query=make"><tt>make</tt></a>
と打つだけです。
しかしながら、最も便利な (そして一般的な) 方法は、
FreeBSD のインストール時に
<a href="ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/ports/ports.tar.gz">
ports 階層全体</a> をインストールし、
すべての ports 一覧のフレームワークをダウンロードすることです。
何千ものアプリケーションが、すぐに使えるようになります。
</p>

<p>
各 ports の <tt>Makefile</tt>は自動的に、ローカルディスクや CDROM, 
<a href="http://www.freebsd.org/cgi/man.cgi?query=ftp"><tt>ftp</tt></a> 経由で
アプリケーションのソースコードを取ってきて、
あなたのシステム上で展開し、パッチをあて、
コンパイルします。
問題がないようなら、あとは <tt>make install</tt>
とするだけでアプリケーションをインストールして
パッケージシステムへ登録できます。</p>

<p>ほとんどの ports には、すべてをコンパイルする時間を節約できる、
あらかじめコンパイルされた <tt>package</tt> もあります。
それぞれの port には対応する package へのリンクがありますので、
そのファイルをダウンロードして 
<a href="http://www.freebsd.org/cgi/man.cgi?query=pkg_add"><tt>pkg_add</tt></a>
コマンドを実行することもできますし、また <tt>pkg_add</tt> ではファイル名
と同じく FTP URL を使うこともできるのでリンク先を <tt>pkg_add</tt>
することもできます。</p>

<p>もう少し詳しく知りたい場合には、
<a href="../../doc/ja_JP.eucJP/books/handbook/">FreeBSD ハンドブック</a> にある
<a href="../../doc/ja_JP.eucJP/books/handbook/ports.html">アプリケーションのインストール: Package と Ports</a>
を、また、新しい ports を作るための情報は
<a href="../../doc/ja_JP.eucJP/books/porters-handbook/index.html">port 作成者のためのハンドブック</a>
を参照してください。</p>
<hr>

<h3>ports を最新に維持する</h3>

<p>
これらのウェブページの ports 一覧は、頻繁にアップデートされています。
(<tt>japanese/</tt> のように) 直感的には独立していると思われるものでも、
多くの ports はツリーの他の部分に依存しているので、
すべてのコレクションを最新に更新することが強く推奨されています。
</p>

<p>ports/packages の追加、更新、削除についての情報や、
どのアプリケーションが
ports/packages になっているかの検索については、本サイトの
<a href="http://www.FreeBSD.org/cgi/ports.cgi">
FreeBSD ports の更新情報</a> を参照してください。
または、<a href="http://www.FreshPorts.org">FreshPorts.org</a>
を訪れて、サイトを閲覧したり、ホストされているリストを購読してください。
</p>

<FORM METHOD="GET" ACTION="http://www.FreeBSD.org/cgi/ports.cgi">
検索:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">すべて</OPTION>
<OPTION VALUE="name">package 名</OPTION>
<OPTION VALUE="text">説明</OPTION>
<OPTION VALUE="pkgdescr">詳しい説明</OPTION>
<OPTION VALUE="maintainer">保守担当者</OPTION>
<OPTION VALUE="requires">必要なもの</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="検索">
</FORM>
