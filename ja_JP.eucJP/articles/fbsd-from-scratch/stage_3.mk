# stage_3.mk - FreeBSD From Scratch, 第 3 段階: ports をインストールした後の設定
#              Usage: make -f stage_3.mk all     (すべての設定を行なう)
#                or   make -f stage_3.mk target  (target の設定を行なう)
#
# すべての target が、複数回実行しても悪影響をおよぼさないように
# 確認しておくとよい。
#
# $FreeBSD$
# Original revision: 1.1

.POSIX:

message:
	@echo "Please use one of the following targets:"
	@echo "config_apache"
	@echo "config_inn"
	@echo "config_javaplugin"
	@echo "config_privoxy"
	@echo "config_setiathome"
	@echo "config_sgml"
	@echo "config_sudo"
	@echo "config_TeX"
	@echo "config_tin"
	@echo "config_uucp"
	@echo "all -- all of the above"

all: config_apache \
	config_inn \
	config_javaplugin \
	config_privoxy \
	config_setiathome \
	config_sgml \
	config_sudo \
	config_TeX \
	config_tin \
	config_uucp

config_apache:
	# 1. httpd.conf の変更
	perl -pi \
	-e 's/#ServerName new.host.name/ServerName hal9000.s.shuttle.de/;' \
	-e 's/^ServerAdmin.*/ServerAdmin schweikh\@schweikhardt.net/;' \
	-e 's,/usr/local/www/cgi-bin/,/home/opt/www/cgi-bin/,;' \
	  /usr/local/etc/apache2/httpd.conf
	# 2. ウェブページに対するシンボリックリンクの作成
	cd /usr/local/www/data; \
	ln -fs /home/schweikh/prj/homepage schweikhardt.net; \
	ln -fs /home/opt/www/test .

config_inn:
	pw usermod -n news -d /usr/local/news -s /bin/sh
	# ニュースシステムの初期設定
	cd /home/root/setup; \
	install -C -o news -g news -m 664 active newsgroups /usr/local/news/db
	# port の innd.sh は壊れていて、
	#存在しない history.pag をチェックしようとする。
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
	perl -pi                                                   \
	-e 's/^(organization:\s*).*/$$1 An Open Pod Bay Door/;'    \
	-e 's/^(pathhost:\s*).*/$$1 hal9000.schweikhardt.net/;'    \
	-e 's/^(server:).*/$$1 localhost/;'                        \
	-e 's/^(domain:).*/$$1 schweikhardt.net/;'                 \
	-e 's/^(fromhost:).*/$$1 schweikhardt.net/;'               \
	-e 's,^(moderatormailer:).*,$$1 \%s\@moderators.isc.org,;' \
	-e 's,/usr/local/news/spool,/share/news/spool,;'           \
	/usr/local/news/etc/inn.conf

config_javaplugin:
	cd /usr/local/lib/netscape-linux/plugins; \
	if ! test -h javaplugin.so; then \
		ln -s ../../../linux-sun-jdk1.3.1/jre/plugin/i386/ns4/javaplugin.so; \
	fi; \
	ls -l javaplugin.so

config_privoxy:
	install -C -o root -g wheel -m 644 config /usr/local/etc/privoxy

config_setiathome:
	perl -pi \
	-e 's,^.*seti_wrkdir.*#,seti_wrkdir=/home/nobody/setiathome #,;' \
	/usr/local/etc/rc.setiathome.conf

config_sgml:
	cp -p /usr/local/share/gmat/sgml/ISO_8879-1986/entities/* \
	      /usr/local/share/sgml/docbook/4.1

config_sudo:
	if ! grep -q schweikh /usr/local/etc/sudoers; then \
		echo 'schweikh ALL = (ALL) NOPASSWD: ALL' >> /usr/local/etc/sudoers; \
	fi

config_TeX:
	# textproc/docproj では、FreeBSD ハンドブックを JadeTeX で
	# タイプセットするには、次の値を設定するよう指示されている
	perl -pi                                   \
	-e 's/^% original texmf.cnf/% texmf.cnf/;' \
	-e 's/^(hash_extra\s*=).*/$$1 60000/;'     \
	-e 's/^(pool_size\s*=).*/$$1 1000000/;'    \
	-e 's/^(max_strings\s*=).*/$$1 70000/;'    \
	-e 's/^(save_size\s*=).*/$$1 10000/;'      \
	/usr/local/share/texmf/web2c/texmf.cnf

config_tin:
	# tin が設定したファイルを読むように設定
	printf "%s\n%s\n%s\n"                              \
		"activefile=/usr/local/news/db/active"         \
		"newsgroupsfile=/usr/local/news/db/newsgroups" \
		"spooldir=/share/news/spool/articles"          \
	>/usr/local/etc/tin.defaults

config_uucp:
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

# EOF $RCSfile: stage_3.mk,v $    vim: tabstop=4:
