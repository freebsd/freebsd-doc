# stage_3.mk - FreeBSD From Scratch, 第 3 段階: ports をインストールした後の設定
#              Usage: make -f stage_3.mk all     (すべての設定を行なう)
#                or   make -f stage_3.mk target  (target の設定を行なう)
#
# 著者:      Jens Schweikhardt
#
# すべての target が、複数回実行しても悪影響をおよぼさないように
# 確認しておくとよい。
#
# $Id: stage_3.mk,v 1.2 2006-03-13 16:46:15 rushani Exp $
# $FreeBSD$
# Original revision: 1.4

.POSIX:

message:
	@echo "Please use one of the following targets:"
	@echo "config_apache"
	@echo "config_firefox"
	@echo "config_inn"
	@echo "config_javaplugin"
	@echo "config_nullplugin"
	@echo "config_privoxy"
	@echo "config_smartd"
	@echo "config_sudo"
	@echo "config_TeX"
	@echo "config_tin"
	@echo "config_uucp"
	@echo "all -- all of the above"


all: \
	config_apache \
	config_firefox \
	config_inn \
	config_javaplugin \
	config_nullplugin \
	config_privoxy \
	config_smartd \
	config_sudo \
	config_TeX \
	config_tin \
	config_uucp


config_apache:
	# 1. httpd.conf の変更
	perl -pi \
	-e 's/^\s*ServerAdmin.*/ServerAdmin schweikh\@schweikhardt.net/;' \
	-e 's/^\s*Listen.*/Listen 127.0.0.1:80/;' \
	-e 's/^\s*StartServers.*/StartServers 2/;' \
	-e 's/^\s*MinSpareServers.*/MinSpareServers 2/;' \
	-e 's,/usr/local/www/cgi-bin/,/home/opt/www/cgi-bin/,;' \
	  /usr/local/etc/apache2/httpd.conf
	# 2. ウェブページに対するシンボリックリンクの作成
	cd /usr/local/www/data; \
	ln -fs /home/schweikh/prj/homepage schweikhardt.net; \
	ln -fs /home/opt/www/test .
	# httpd.conf が変更されていないか確認する。
	@if ! cmp -s /usr/local/etc/apache2/httpd.conf httpd.conf; then \
		echo "ATTENTION: the httpd.conf has changed. Please examine if"; \
		echo "the modifications are still correct. Here is the diff:"; \
		diff -u /usr/local/etc/apache2/httpd.conf httpd.conf; \
	fi
	if test -f /var/run/httpd.pid; then \
		/usr/local/etc/rc.d/apache2.sh stop; \
		/usr/local/etc/rc.d/apache2.sh start; \
	else \
		/usr/local/etc/rc.d/apache2.sh start; \
	fi

config_firefox:
	# wheel グループが書き込めるようにして、すべての extension をインストー
	# ルできるようにする。
	chmod -R g+w /usr/X11R6/lib/firefox/lib/mozilla-1.6/chrome

config_inn:
	pw usermod -n news -d /usr/local/news -s /bin/sh
	mkdir -p /share/news/spool/outgoing \
	         /share/news/spool/incoming \
	         /share/news/spool/articles \
	         /share/news/spool/overview \
	         /share/news/spool/tmp      \
	         /share/news/db
	chown -R news:news /share/news
	# ニュースシステムの初期設定
	cd /home/root/setup; \
	if test ! -f /share/news/db/active; then \
		echo "installing /share/news/db/active"; \
		install -C -o news -g news -m 664 active /share/news/db; \
	fi; \
	if test ! -f /share/news/db/newsgroups; then \
		echo "installing /share/news/db/newsgroups"; \
		install -C -o news -g news -m 664 newsgroups /share/news/db; \
	fi
	# port の innd.sh は壊れていて、
	# 存在しない history.pag をチェックしようとする。
	cd /home/root/setup; \
	install -C -o root -g wheel -m 555 innd.sh /usr/local/etc/rc.d
	# 格納方法の設定
	cd /home/root/setup;      \
	printf "%s\n%s\n%s\n%s\n" \
		"method tradspool {"  \
		"  newsgroups: *"     \
		"  class: 0"          \
		"}"                   \
	>storage.conf;            \
	install -C -o news -g news -m 664 storage.conf /usr/local/news/etc
	# newsfeeds の設定
	printf "%s\n%s\n" \
		"ME:*::"      \
		"shuttle/news2.shuttle.de:!junk,!control:B32768/512,Tf,Wfb:" \
	>/usr/local/news/etc/newsfeeds
	# inn.conf の設定
	perl -pi                                                        \
	-e 's/^#*\s*(organization:\s*).*/$$1"An Open Pod Bay Door"/;'   \
	-e 's/^#*\s*(pathhost:\s*).*/$$1hal9000.schweikhardt.net/;'     \
	-e 's/^#*\s*(server:).*/$$1 localhost/;'                        \
	-e 's/^#*\s*(domain:).*/$$1 schweikhardt.net/;'                 \
	-e 's/^#*\s*(fromhost:).*/$$1 schweikhardt.net/;'               \
	-e 's,^#*\s*(moderatormailer:).*,$$1 \%s\@moderators.isc.org,;' \
	-e 's,^#*\s*(pathdb:\s*).*,$$1/share/news/db,;'                 \
	-e 's,/usr/local/news/spool,/share/news/spool,;'                \
	/usr/local/news/etc/inn.conf
	# 履歴が全く存在しなければ、空の履歴を作成する。
	# /usr/ports/news/inn-stable/Makefile の post-install 参照。
	cd /share/news/db; \
	if test ! -f history; then \
		touch history; \
		chmod 644 history; \
		chown news:news history; \
		su -fm news -c "/usr/local/news/bin/makedbz -i"; \
		for s in dir hash index; do \
			mv history.n.$${s} history.$${s}; \
		done; \
	fi
	# send-uucp を設定する。
	echo shuttle:shuttle >/usr/local/news/etc/send-uucp.cf
	# inncheck を満足させる。
	cd /usr/local/news/etc; \
	chown news:news *; \
	chmod 640 control.ctl expire.ctl nntpsend.ctl readers.conf
	/usr/local/news/bin/inncheck
	# inn.conf が変更されていないか確認する。
	@if ! cmp -s /usr/local/news/etc/inn.conf inn.conf; then \
		echo "ATTENTION: the inn.conf has changed. Please examine if"; \
		echo "the modifications are still correct. Here is the diff:"; \
		diff -u /usr/local/news/etc/inn.conf inn.conf; \
	fi
	if ! test -f /usr/local/news/run/innd.pid; then \
		/usr/local/etc/rc.d/innd.sh start; \
	fi

config_javaplugin:
	# Mozilla Firefox:
	cd /usr/X11R6/lib/firefox/lib/mozilla-1.6/plugins; \
	ln -fs /usr/local/jdk1.4.2/jre/plugin/i386/ns610/libjavaplugin_oji.so
	# Plain Mozilla:
	#cd /usr/X11R6/lib/mozilla/plugins; \
	#ln -fs /usr/local/jdk1.4.2/jre/plugin/i386/ns610/libjavaplugin_oji.so

# nullplugin を邪魔にならないように削除する。また、.mozilla/*/*/prefs.js に
# 次の項目を追加する。
# user_pref("plugin.display_plugin_downloader_dialog", false);
# これで入手できないプラグイン (flash 等) についてポップアップダイアログが
# 出ないようになる。
config_nullplugin:
	find /usr/X11R6/lib -name libnullplugin.so -exec mv {} {}.orig \;

config_privoxy:
	install -C -o root -g wheel -m 644 conf/privoxy/config \
		/usr/local/etc/privoxy
	install -C -o root -g wheel -m 755 conf/privoxy/privoxy.sh \
		/usr/local/etc/rc.d
	/usr/local/etc/rc.d/privoxy.sh restart

config_smartd:
	cp smartd.sh /usr/local/etc/rc.d/smartd.sh
	cp smartd.conf /usr/local/etc/smartd.conf

config_sudo:
	if ! grep -q schweikh /usr/local/etc/sudoers; then \
		echo 'schweikh ALL = (ALL) NOPASSWD: ALL' >> /usr/local/etc/sudoers; \
	fi

config_TeX:
	# textproc/docproj では、FreeBSD ハンドブックを JadeTeX で
	# タイプセットするには、次の値を設定するよう指示されている
	perl -pi                                      \
	-e 's/^% original texmf.cnf/% texmf.cnf/;'    \
	-e 's/^(hash_extra\s*=\s*).*/$${1}60000/;'    \
	-e 's/^(pool_size\s*=\s*).*/$${1}1000000/;'   \
	-e 's/^(max_strings\s*=\s*).*/$${1}70000/;'   \
	-e 's/^(save_size\s*=\s*).*/$${1}10000/;'     \
	/usr/local/share/texmf/web2c/texmf.cnf
	# texmf.cnf が変更されていないか確認する。
	@if ! cmp -s /usr/local/share/texmf/web2c/texmf.cnf texmf.cnf; then \
		echo "ATTENTION: the texmf.cnf has changed. Please examine if"; \
		echo "the modifications are still correct. Here is the diff:"; \
		diff -u /usr/local/share/texmf/web2c/texmf.cnf texmf.cnf; \
	fi

config_tin:
	# tin が設定したファイルを読むように設定
	printf "%s\n%s\n%s\n"                          \
		"activefile=/share/news/db/active"         \
		"newsgroupsfile=/share/news/db/newsgroups" \
		"spooldir=/share/news/spool/articles"      \
	>/usr/local/etc/tin.defaults

config_uucp:
	cd /etc/mail; make install SENDMAIL_MC=/etc/mail/hal9000.mc
	# su(1) が動作するように uucp ユーザのシェルを正しい uucico にする。
	chpass -s /usr/local/libexec/uucp/uucico uucp
	# UUCP が /usr/bin/rnews を見つけられるようにする
	cd /usr/bin; ln -fs ../local/news/bin/rnews .
	# 実際の UUCP の設定
	echo nodename js2015           > /usr/local/etc/uucp/config
	echo shuttle js2015 `cat uucp` > /usr/local/etc/uucp/call
	printf 'port tcp\ntype tcp\n'  > /usr/local/etc/uucp/port
	printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n" \
		"call-login    *"                 \
		"call-password *"                 \
		"time          any"               \
		"system        shuttle"           \
		"address       mail.s.shuttle.de" \
		"commands      rmail rnews"       \
		"port          tcp"               \
	>/usr/local/etc/uucp/sys
	cd /usr/local/etc/uucp; chown uucp:uucp *; chmod o-rwx *
	# 起動後に uucico を実行する
	mkdir -p /usr/local/etc/rc.d; cp uucp.sh /usr/local/etc/rc.d

# vim: tabstop=4:
# EOF $RCSfile: stage_3.mk,v $
