#!/bin/sh

# builditinator.sh
# written by Adam Weinberger <adamw@FreeBSD.org>
# owned by the FreeBSD GNOME team <freebsd-gnome@FreeBSD.org>
# under the BSD Public Licence
# Adam hungry. need taco. unga.

# handles the basic processes of testing old and new GNOME versions


#### Be sure to change these variables to match your system:

LOGDIR=/build/output
MCOM_PORTS=/usr/ports/MARCUSCOM/ports
MCOM_PORTSTOOLS=/usr/ports/MARCUSCOM/portstools
FBSD_PORTS=/usr/ports

CVSUP_CONF=/etc/cvsup.conf
# Re-order these to install them in differing orders
# (low-key dependency checking):
METAPORTS="${METAPORTS} x11/gnome2"
METAPORTS="${METAPORTS} x11/gnome2-fifth-toe"
METAPORTS="${METAPORTS} x11/gnome2-power-tools"
METAPORTS="${METAPORTS} editors/gnome2-office"
METAPORTS="${METAPORTS} devel/gnome2-hacker-tools"


#### There are no interesting user-settable variables below this line.

BUILDITINATOR_VERSION=2.8.0

OLDVER=2.6
NEWVER=2.8

echo "`basename $0` version ${BUILDITINATOR_VERSION}"

clean() {
	echo "==> Cleaning system..."
	echo "Clearing out work directories..."
	find ${FBSD_PORTS} ${MCOM_PORTS} -type d -name work | xargs rm -R 2>/dev/null
	echo "Removing all ports..."
	pkg_delete -a
	echo "Finding missing plist items in /usr/local..."
	find /usr/local -type f -o -type l > ${LOGDIR}/missing-plist-items-localbase 2>/dev/null
	echo -n "Number of items found: "
	wc -l ${LOGDIR}/missing-plist-items-localbase ; echo
	echo "Finding missing plist items in /usr/X11R6..."
	find /usr/X11R6 -type f -o -type l > ${LOGDIR}/missing-plist-items-x11base 2>/dev/null
	echo -n "Number of items found: "
	wc -l ${LOGDIR}/missing-plist-items-x11base ; echo
	echo "Backing up extra files..."
	tar cfy ${LOGDIR}/localbase-missing-items.tbz /usr/local 2>/dev/null
	tar cfy ${LOGDIR}/x11base-missing-items.tbz /usr/X11R6 2>/dev/null
	echo "Removing /usr/local..."
	rm -R /usr/local 2>/dev/null
	echo "Removing /usr/X11R6..."
	rm -R /usr/X11R6 2>/dev/null
}

update() {
	echo "==> Updating repositories..."
	for dir in `find ${MCOM_PORTS} -type d -name files | sed -e "s|${MCOM_PORTS}|${FBSD_PORTS}|g"`
	do
		rm -R ${dir} 2>/dev/null
	done
	[ -f /usr/local/bin/cvsup ] || pkg_add -r cvsup-without-gui
	cvsup ${CVSUP_CONF}
	make -C ${MCOM_PORTSTOOLS} clean all
	install -m 755 ${MCOM_PORTSTOOLS}/marcusmerge.sh /usr/local/bin/marcusmerge
	install -m 755 ${MCOM_PORTSTOOLS}/gnome_upgrade.sh /usr/local/bin/
}

prime() {
	echo "==> Priming system..."
	make -C ${FBSD_PORTS}/sysutils/portupgrade install clean
	pkgdb -F
	WITHOUT_X11=yes portinstall editors/vim
}

install_new() {
	echo "==> Installing metaports..."
	for port in ${METAPORTS}
	do
		rm ${LOGDIR}/`basename ${port}`output.log 2>/dev/null
		portinstall ${port} 2>&1 | tee ${LOGDIR}/`basename ${port}`output.log
	done
}

upgrade() {
	echo "==> Updating to ${NEWVER}..."
	/usr/local/bin/gnome_upgrade.sh
}



cat <<MENU

BUILD ACTIONS
-------------

1) Run full upgrade cycle
2) Install fresh ${OLDVER} system
3) Install fresh ${NEWVER} system
4) Upgrade to ${NEWVER}
5) Freshen ${OLDVER} system
6) Freshen ${NEWVER} system
7) Clean and prime system

MENU
read -p "Select build action [1]: " action

# do all interactive thingers at the beginning
cd ${MCOM_PORTS} && cvs up
cd ${MCOM_PORTSTOOLS} && cvs up

case "${action}" in
	"2")
		clean
		update
		prime
		install_new
		exit
		;;
	"3")
		clean
		update
		prime
		marcusmerge
		install_new
		exit
		;;
	"4")
		update
		marcusmerge
		upgrade
		exit
		;;
	"5")
		update
		pkgdb -F
		portupgrade -a
		exit
		;;
	"6")
		update
		marcusmerge
		pkgdb -F
		portupgrade -a
		exit
		;;
	"7")
		clean
		update
		prime
		exit
		;;
	*)
		clean
		update
		prime
		install_new
		marcusmerge
		upgrade
		exit
		;;
esac

echo "Here there be tacos"
