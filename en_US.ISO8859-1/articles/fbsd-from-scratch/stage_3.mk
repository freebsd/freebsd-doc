# stage_3.mk - FreeBSD From Scratch, Stage 3: Ports Post-Configuration.
#              Usage: make -f stage_3.mk all     (configure everything)
#                or   make -f stage_3.mk target  (just configure target)
#
# Author:      Jens Schweikhardt
#
# It is a good idea to make sure any target can be made more than
# once without ill effect.
#
# $Id: stage_3.mk,v 1.5 2008-12-03 21:59:51 schweikh Exp $
# $FreeBSD$

.POSIX:

message:
	@echo "Please use one of the following targets:"
	@echo "config_apache"
	@echo "config_cups"
	@echo "config_firefox"
	@echo "config_inn"
	@echo "config_javaplugin"
	@echo "config_openoffice"
	@echo "config_sudo"
	@echo "config_TeX"
	@echo "config_tin"
	@echo "config_wdm"
	@echo "config_uucp"
	@echo "all -- all of the above"

all: \
	config_apache \
	config_cups \
	config_firefox \
	config_inn \
	config_javaplugin \
	config_openoffice \
	config_sudo \
	config_TeX \
	config_tin \
	config_wdm \
	config_uucp

APACHE = apache22
config_apache:
	# 1. Modify httpd.conf.
	perl -pi \
	-e 's/^\s*ServerAdmin.*/ServerAdmin schweikh\@schweikhardt.net/;' \
	-e 's/^#?ServerName .*/ServerName hal9000.schweikhardt.net:80/;' \
	-e 's/^\s*Listen.*/Listen 127.0.0.1:80/;' \
	-e 's/^\s*Deny from all/    Allow from 127.0.0.1/i;' \
	-e 's,/usr/local/www/$(APACHE)/cgi-bin/,/home/opt/www/cgi-bin/,;' \
	  /usr/local/etc/$(APACHE)/httpd.conf
	cp w3c-validator.conf /usr/local/etc/$(APACHE)/Includes
	# 2. Restore symlinks to web pages.
	cd /usr/local/www/$(APACHE)/data && \
	ln -fs /home/schweikh/prj/homepage schweikhardt.net && \
	ln -fs /home/opt/www/test .
	# 3. Restore W3C Validator config.
	mkdir -p /etc/w3c
	cp /usr/local/www/validator/htdocs/config/validator.conf.sample \
		/etc/w3c/validator.conf
	perl -pi \
	-e 's/^Allow Private IPs.*/Allow Private IPs = yes/;' \
		/etc/w3c/validator.conf
	# Test if the httpd.conf has changed.
	@if ! cmp -s /usr/local/etc/$(APACHE)/httpd.conf httpd.conf; then \
		echo "ATTENTION: the httpd.conf has changed. Please examine if"; \
		echo "the modifications are still correct. If so you can simply"; \
		echo "cp /usr/local/etc/$(APACHE)/httpd.conf httpd.conf"; \
		echo "to make this message go away. Here is the diff:"; \
		diff -u /usr/local/etc/$(APACHE)/httpd.conf httpd.conf; \
	fi
	if test -f /var/run/httpd.pid; then \
		/usr/local/etc/rc.d/$(APACHE) stop; \
		/usr/local/etc/rc.d/$(APACHE) start; \
	else \
		/usr/local/etc/rc.d/$(APACHE) start; \
	fi

# The original ppd file is from http://www.cups.org/ppd.php?L63+I0+T+Q2300
# = http://www.cups.org/ppd/hp/de/hpc2325s.ppd.gz
config_cups:
	chmod 644 /usr/local/etc/cups/cupsd.conf
	cp printers.conf /usr/local/etc/cups/printers.conf
	cp LaserJet_2300d.ppd /usr/local/etc/cups/ppd/LaserJet_2300d.ppd

config_firefox:
	# Make this group wheel writable to allow extensions being installed.
	chmod -R g+w /usr/local/lib/firefox3/chrome

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
	cd /home/root/setup && \
	if test ! -f /share/news/db/active; then \
		echo "installing /share/news/db/active"; \
		install -C -o news -g news -m 664 active /share/news/db; \
	fi; \
	if test ! -f /share/news/db/newsgroups; then \
		echo "installing /share/news/db/newsgroups"; \
		install -C -o news -g news -m 664 newsgroups /share/news/db; \
	fi
	# Configure storage method.
	cd /home/root/setup &&    \
	printf "%s\n%s\n%s\n%s\n" \
		"method tradspool {"  \
		"  newsgroups: *"     \
		"  class: 0"          \
		"}"                   \
	>storage.conf &&          \
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
	set -e; cd /share/news/db; \
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
	set -e; cd /usr/local/news/etc; \
	chown news:news *; \
	chmod 640 control.ctl expire.ctl nntpsend.ctl readers.conf
	/usr/local/news/bin/inncheck
	# Test if the inn.conf has changed.
	@if ! cmp -s /usr/local/news/etc/inn.conf inn.conf; then \
		echo "ATTENTION: the inn.conf has changed. Please examine if"; \
		echo "the modifications are still correct. If so you can simply"; \
		echo "cp /usr/local/news/etc/inn.conf inn.conf"; \
		echo "to make this message go away. Here is the diff:"; \
		diff -u /usr/local/news/etc/inn.conf inn.conf; \
	fi
	if ! test -f /usr/local/news/run/innd.pid; then \
		/usr/local/etc/rc.d/innd start; \
	fi

config_javaplugin:
	cd /usr/local/lib/firefox3/plugins && \
	  ln -fs /usr/local/jdk1.6.0/jre/plugin/$$(uname -m)/ns7/libjavaplugin_oji.so

config_openoffice:
	# Copy some truetype files so ooo can use them.
	find /usr/local/openoffice.org* -type d -name truetype \
		-exec echo cp *.ttf {} \; -exec cp *.ttf {} \;

config_sudo:
	if ! grep -q schweikh /usr/local/etc/sudoers; then \
		echo 'schweikh ALL = (ALL) NOPASSWD: ALL' >> /usr/local/etc/sudoers; \
	fi
	chmod 440 /usr/local/etc/sudoers

config_TeX:
	# textproc/docproj advises: to typeset the FreeBSD Handbook with JadeTeX,
	# change the following settings to the listed values:
	perl -pi                                      \
	-e 's/^% original texmf.cnf/% texmf.cnf/;'    \
	-e 's/^(hash_extra\s*=\s*).*/$${1}60000/;'    \
	-e 's/^(pool_size\s*=\s*).*/$${1}1000000/;'   \
	-e 's/^(max_strings\s*=\s*).*/$${1}70000/;'   \
	-e 's/^(save_size\s*=\s*).*/$${1}10000/;'     \
	/usr/local/share/texmf/web2c/texmf.cnf
	# Test if the texmf.cnf has changed.
	@if ! cmp -s /usr/local/share/texmf/web2c/texmf.cnf texmf.cnf; then \
		echo "ATTENTION: the texmf.cnf has changed. Please examine if"; \
		echo "the modifications are still correct. If so you can simply"; \
		echo "cp /usr/local/share/texmf/web2c/texmf.cnf texmf.cnf"; \
		echo "to make this message go away. Here is the diff:"; \
		diff -u /usr/local/share/texmf/web2c/texmf.cnf texmf.cnf; \
	fi

config_tin:
	# Point tin to our files.
	printf "%s\n%s\n%s\n"                          \
		"activefile=/share/news/db/active"         \
		"newsgroupsfile=/share/news/db/newsgroups" \
		"spooldir=/share/news/spool/articles"      \
	>/usr/local/etc/tin.defaults

config_wdm:
	cp daemon1-JS-1600x1200.jpg FreeBSD_small.png \
		/usr/local/lib/X11/wdm/pixmaps
	perl -pi \
	-e 's,^(DisplayManager\*wdmBg:).*,\1 pixmap:/usr/local/lib/X11/wdm/pixmaps/daemon1-JS-1600x1200.jpg,;' \
	-e 's,^(DisplayManager\*wdmLogo:).*,\1 /usr/local/lib/X11/wdm/pixmaps/FreeBSD_small.png,;' \
	-e 's,^(DisplayManager\*wdmWm:).*,\1 ctwm:icewm:xfce4:tvtwm,;' \
		/usr/local/lib/X11/wdm/wdm-config
	@if ! cmp -s /usr/local/lib/X11/wdm/wdm-config wdm-config; then \
		echo "ATTENTION: the wdm-config has changed. Please examine if"; \
		echo "the modifications are still correct. If so you can simply"; \
		echo "cp /usr/local/lib/X11/wdm/wdm-config wdm-config"; \
		echo "to make this message go away. Here is the diff:"; \
		diff -u /usr/local/lib/X11/wdm/wdm-config wdm-config; \
	fi

config_uucp:
	cd /etc/mail && make install SENDMAIL_MC=/etc/mail/hal9000.mc
	# Make the uucp user's shell the correct uucico, so su(1) works.
	chpass -s /usr/local/libexec/uucp/uucico uucp
	# UUCP expects to find /usr/bin/rnews.
	cd /usr/bin && ln -fs ../local/news/bin/rnews .
	# Actual UUCP configuration.
	echo nodename js2015           > /usr/local/etc/uucp/config
	echo shuttle js2015 `cat uucp` > /usr/local/etc/uucp/call
	printf 'port tcp\ntype tcp\n'  > /usr/local/etc/uucp/port
	printf "%s\n"                         \
		"call-login    *"                 \
		"call-password *"                 \
		"time          any"               \
		"system        shuttle"           \
		"address       mail.s.shuttle.de" \
		"commands      rmail rnews"       \
		"port          tcp"               \
	>/usr/local/etc/uucp/sys
	cd /usr/local/etc/uucp && chown uucp:uucp * && chmod o-rwx *
	# Trigger uucico after booting.
	mkdir -p /usr/local/etc/rc.d
	cp uucp.sh /usr/local/etc/rc.d
	# Rebuild the aliases.db.
	cp aliases /etc/mail/aliases
	newaliases

# vim: tabstop=4:
# EOF $RCSfile: stage_3.mk,v $
