# stage_3.mk - FreeBSD From Scratch, Stage 3: Ports Post-Configuration.
#              Usage: make -f stage_3.mk all     (config everything)
#                or   make -f stage_3.mk target  (to just config target)
#
# Author:      Jens Schweikhardt
#
# It is a good idea to make sure any target can be made more than
# once without ill effect.
#
# $Id: stage_3.mk,v 1.3 2004-01-21 19:39:26 schweikh Exp $
# $FreeBSD$

.POSIX:

message:
	@echo "Please use one of the following targets:"
	@echo "config_apache"
	@echo "config_firebird"
	@echo "config_inn"
	@echo "config_javaplugin"
	@echo "config_nullplugin"
	@echo "config_privoxy"
	@echo "config_sgml"
	@echo "config_smokeping"
	@echo "config_sudo"
	@echo "config_TeX"
	@echo "config_tin"
	@echo "config_uucp"
	@echo "all -- all of the above"


all: \
	config_apache \
	config_firebird \
	config_inn \
	config_javaplugin \
	config_nullplugin \
	config_privoxy \
	config_sgml \
	config_smokeping \
	config_sudo \
	config_TeX \
	config_tin \
	config_uucp

config_apache:
	# 1. Modify httpd.conf.
	perl -pi \
	-e 's/^\s*ServerAdmin.*/ServerAdmin schweikh\@schweikhardt.net/;' \
	-e 's/^\s*Listen.*/Listen 127.0.0.1:80/;' \
	-e 's/^\s*StartServers.*/StartServers 2/;' \
	-e 's/^\s*MinSpareServers.*/MinSpareServers 2/;' \
	-e 's,/usr/local/www/cgi-bin/,/home/opt/www/cgi-bin/,;' \
	  /usr/local/etc/apache2/httpd.conf
	# 2. Restore symlinks to web pages.
	cd /usr/local/www/data; \
	ln -fs /home/schweikh/prj/homepage schweikhardt.net; \
	ln -fs /home/opt/www/test .
	# Test if the httpd.conf has changed.
	@if ! cmp -s /usr/local/etc/apache2/httpd.conf httpd.conf; then \
		echo "ATTENTION: the httpd.conf has changed. Please examine if"; \
		echo "the modifications are still correct. Here is the diff:"; \
		diff -u /usr/local/etc/apache2/httpd.conf httpd.conf; \
	fi
	if test -f /var/run/httpd.pid; then \
		/usr/local/etc/rc.d/apache2.sh restart; \
	else \
		/usr/local/etc/rc.d/apache2.sh start; \
	fi

config_firebird:
	# Make this group wheel writable to allow extensions being installed.
	chmod -R g+w /usr/X11R6/lib/firebird/lib/mozilla-1.5/chrome

config_inn:
	pw usermod -n news -d /usr/local/news -s /bin/sh
	mkdir -p /share/news/spool/outgoing \
	         /share/news/spool/incoming \
	         /share/news/spool/articles \
	         /share/news/spool/overview \
	         /share/news/spool/tmp      \
	         /share/news/db
	chown -R news:news /share/news
	# Give the news system its initial configuration.
	cd /home/root/setup; \
	if test ! -f /share/news/db/active; then \
		echo "installing /share/news/db/active"; \
		install -C -o news -g news -m 664 active /share/news/db; \
	fi; \
	if test ! -f /share/news/db/newsgroups; then \
		echo "installing /share/news/db/newsgroups"; \
		install -C -o news -g news -m 664 newsgroups /share/news/db; \
	fi
	# The innd.sh that comes with the port is broken, it
	# checks for history.pag which does not exist.
	cd /home/root/setup; \
	install -C -o root -g wheel -m 555 innd.sh /usr/local/etc/rc.d
	# Configure storage method.
	cd /home/root/setup;      \
	printf "%s\n%s\n%s\n%s\n" \
		"method tradspool {"  \
		"  newsgroups: *"     \
		"  class: 0"          \
		"}"                   \
	>storage.conf;            \
	install -C -o news -g news -m 664 storage.conf /usr/local/news/etc
	# Configure newsfeeds.
	printf "%s\n%s\n" \
		"ME:*::"      \
		"shuttle/news2.shuttle.de:!junk,!control:B32768/512,Tf,Wfb:" \
	>/usr/local/news/etc/newsfeeds
	# Configure inn.conf.
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
	# Create empty history, if none there.
	# See post-install in /usr/ports/news/inn-stable/Makefile.
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
	# Configure send-uucp.
	echo shuttle:shuttle >/usr/local/news/etc/send-uucp.cf
	# Satisfy inncheck:
	cd /usr/local/news/etc; \
	chown news:news *; \
	chmod 640 control.ctl expire.ctl nntpsend.ctl readers.conf
	/usr/local/news/bin/inncheck
	# Test if the inn.conf has changed.
	@if ! cmp -s /usr/local/news/etc/inn.conf inn.conf; then \
		echo "ATTENTION: the inn.conf has changed. Please examine if"; \
		echo "the modifications are still correct. Here is the diff:"; \
		diff -u /usr/local/news/etc/inn.conf inn.conf; \
	fi
	if ! test -f /usr/local/news/run/innd.pid; then \
		/usr/local/etc/rc.d/innd.sh start; \
	fi

config_javaplugin:
	# Mozilla Firebird:
	cd /usr/X11R6/lib/firebird/lib/mozilla-1.5/plugins; \
	ln -fs /usr/local/jdk1.4.2/jre/plugin/i386/ns610/libjavaplugin_oji.so
	# Plain Mozilla:
	cd /usr/X11R6/lib/mozilla/plugins; \
	ln -fs /usr/local/jdk1.4.2/jre/plugin/i386/ns610/libjavaplugin_oji.so

# Move the nullplugin out of the way. With a .mozilla/*/*/prefs.js entry of
# user_pref("plugin.display_plugin_downloader_dialog", false);
# this suppresses popup dialogs for unavailable plugins (flash, shockwave, ...)
NULLPLUGINS = /usr/X11R6/lib/mozilla/libnullplugin.so \
              /usr/X11R6/lib/mozilla/plugins/libnullplugin.so

config_nullplugin:
	for p in $(NULLPLUGINS); do \
	    if test -r $$p; then    \
	        mv $$p $$p.orig;    \
	    fi;                     \
	done

config_privoxy:
	install -C -o root -g wheel -m 644 conf/privoxy/config \
		/usr/local/etc/privoxy
	install -C -o root -g wheel -m 755 conf/privoxy/privoxy.sh \
		/usr/local/etc/rc.d
	/usr/local/etc/rc.d/privoxy.sh restart

config_sgml:
	cp -p /usr/local/share/gmat/sgml/ISO_8879-1986/entities/* \
	      /usr/local/share/sgml/docbook/4.1

config_smokeping:
	cp conf/smokeping/config conf/smokeping/basepage.html \
		/usr/local/etc/smokeping
	/usr/local/etc/rc.d/smokeping.sh stop
	/usr/local/etc/rc.d/smokeping.sh start

config_sudo:
	if ! grep -q schweikh /usr/local/etc/sudoers; then \
		echo 'schweikh ALL = (ALL) NOPASSWD: ALL' >> /usr/local/etc/sudoers; \
	fi

config_TeX:
	# textproc/docproj advises: to typeset the FreeBSD Handbook with JadeTeX,
	# change the following settings to the listed values:
	perl -pi                                   \
	-e 's/^% original texmf.cnf/% texmf.cnf/;' \
	-e 's/^(hash_extra\s*=).*/$${1}60000/;'    \
	-e 's/^(pool_size\s*=).*/$${1}1000000/;'   \
	-e 's/^(max_strings\s*=).*/$${1}70000/;'   \
	-e 's/^(save_size\s*=).*/$${1}10000/;'     \
	/usr/local/share/texmf/web2c/texmf.cnf
	# Test if the texmf.cnf has changed.
	@if ! cmp -s /usr/local/share/texmf/web2c/texmf.cnf texmf.cnf; then \
		echo "ATTENTION: the texmf.cnf has changed. Please examine if"; \
		echo "the modifications are still correct. Here is the diff:"; \
		diff -u /usr/local/share/texmf/web2c/texmf.cnf texmf.cnf; \
	fi

config_tin:
	# Point tin to our files.
	printf "%s\n%s\n%s\n"                          \
		"activefile=/share/news/db/active"         \
		"newsgroupsfile=/share/news/db/newsgroups" \
		"spooldir=/share/news/spool/articles"      \
	>/usr/local/etc/tin.defaults

config_uucp:
	cd /etc/mail; make install SENDMAIL_MC=/etc/mail/hal9000.mc
	# Make the uucp user's shell the correct uucico, so su(1) works.
	chpass -s /usr/local/libexec/uucp/uucico uucp
	# UUCP expects to find /usr/bin/rnews.
	cd /usr/bin; ln -fs ../local/news/bin/rnews .
	# Actual UUCP configuration.
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
	# Trigger uucico after booting.
	mkdir -p /usr/local/etc/rc.d; cp uucp.sh /usr/local/etc/rc.d

# vim: tabstop=4:
# EOF $RCSfile: stage_3.mk,v $
