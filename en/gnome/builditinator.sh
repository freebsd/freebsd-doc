#!/bin/sh

# builditinator.sh
# written by Adam Weinberger <adamw@FreeBSD.org>
# pwned by the FreeBSD GNOME team <freebsd-gnome@FreeBSD.org>
# under the BSD Public Licence
# Adam hungry. need taco. unga.

# handles the basic processes of testing old and new GNOME versions

SKIP_CVSUP=${SKIP_CVSUP:=0}

#### Be sure to change these variables to match your system:

LOGDIR=/build/output
MCOM_PORTS=/usr/ports/MARCUSCOM/ports
MCOM_PORTSTOOLS=/usr/ports/MARCUSCOM/portstools
MCOM_PORTSEXP=/usr/ports/MARCUSCOM/ports-experimental
FBSD_PORTS=/usr/ports
MCOM_PATCHES=/usr/ports/PATCHES/marcuscom
FBSD_PATCHES=/usr/ports/PATCHES/freebsd

CVSUP_CONF=/etc/cvsup.conf
# Re-order these to install them in differing orders
# (low-key dependency checking):
METAPORTS="${METAPORTS} x11/gnome2"
METAPORTS="${METAPORTS} x11/gnome2-fifth-toe"
METAPORTS="${METAPORTS} x11/gnome2-power-tools"
METAPORTS="${METAPORTS} editors/gnome2-office"
METAPORTS="${METAPORTS} devel/gnome2-hacker-tools"


#### There are no interesting user-settable variables below this line.

BUILDITINATOR_VERSION=2.7.2

OLDVER=2.6
NEWVER=2.7

echo "`basename $0` version ${BUILDITINATOR_VERSION}"

clean() {
	echo "==> Cleaning system..."
	echo "Clearing out work directories..."
	find ${FBSD_PORTS} ${MCOM_PORTS} ${MCOM_PORTSEXP} -type d -name work | xargs rm -R 2>/dev/null
	echo "Removing all ports..."
	pkg_delete -a
	echo "Finding missing plist items in /usr/local..."
	find /usr/local -type f -o -type l > ${LOGDIR}/missing-plist-items-localbase 2>/dev/null
	echo -n "Number of items found: "
	wc -l ${LOGDIR}/missing-plist-items-localbase | cut -f1 -d/ ; echo
	echo "Finding missing plist items in /usr/X11R6..."
	find /usr/X11R6 -type f -o -type l > ${LOGDIR}/missing-plist-items-x11base 2>/dev/null
	echo -n "Number of items found: "
	wc -l ${LOGDIR}/missing-plist-items-x11base | cut -f1 -d/ ; echo
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
# prevent stale patches by removing files/ directories prn before cvsupping.
	for dir in `find ${MCOM_PORTS} -type f -name distinfo | sed -e "s|${MCOM_PORTS}|${FBSD_PORTS}|g; s|/distinfo|/files/|g"`
	do
		rm -R ${dir} 2>/dev/null
	done
	for dir in `find ${MCOM_PORTSEXP} -type f -name distinfo | sed -e "s|${MCOM_PORTSEXP}|${FBSD_PORTS}|g; s|/distinfo|/files/|g"`
	do
		rm -R ${dir} 2>/dev/null
	done
	if [ ! -f /usr/local/bin/cvsup ]; then
		if [ -f ~/cvsup-without-gui.tgz ]; then
			pkg_add ~/cvsup-without-gui.tgz
		else
			pkg_add -r cvsup-without-gui
		fi
	fi
	if [ ${SKIP_CVSUP} = 0 ]; then
		cvsup ${CVSUP_CONF}
	fi
	make -C ${MCOM_PORTSTOOLS} clean all
	mkdir -p /usr/local/bin
	install -m 755 ${MCOM_PORTSTOOLS}/marcusmerge.sh /usr/local/bin/marcusmerge
	install -m 755 ${MCOM_PORTSTOOLS}/gnome_upgrade.sh /usr/local/bin/
}

prime() {
	echo "==> Priming system..."
	make -C ${FBSD_PORTS}/sysutils/portupgrade install clean
	pkgdb -F
# if you prefer any particular tools in your build environment, put them here.
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

patches() {
	if find ${MCOM_PATCHES} -type f 2>/dev/null; then
		for patchfile in ${MCOM_PATCHES}/*; do
			cd ${MCOM_PORTS} && patch -p0 < patchfile
		done
	fi
	if find ${FBSD_PATCHES} -type f 2>/dev/null; then
		for patchfile in ${FBSD_PATCHES}/*; do
			cd ${FBSD_PORTS} && patch -p0 < patchfile
		done
	fi
}

cat <<MENU

BUILD ACTIONS
-------------

1) Run full upgrade cycle
2) Install fresh ${OLDVER} system
3) Install fresh ${NEWVER} system
4) Install fresh ${NEWVER}-experimental system
5) Upgrade to ${NEWVER}
6) Freshen ${OLDVER} system
7) Freshen ${NEWVER} system
8) Freshen ${NEWVER}-experimental system
9) Clean and prime system

MENU
read -p "Select build action [1]: " action

# do all interactive thingers at the beginning
cd ${MCOM_PORTS} && cvs up
cd ${MCOM_PORTSTOOLS} && cvs up
cd ${MCOM_PORTSEXP} && cvs up

case "${action}" in
	"2")
		clean
		update
		patches
		prime
		install_new
		exit
		;;
	"3")
		clean
		update
		marcusmerge
		patches
		prime
		install_new
		exit
		;;
	"4")
		clean
		update
		marcusmerge -x
		patches
		prime
		install_new
		exit
		;;
	"5")
		update
		marcusmerge ${expargs}
		patches
		upgrade
		exit
		;;
	"6")
		update
		patches
		pkgdb -F
		portupgrade -a
		exit
		;;
	"7")
		update
		marcusmerge
		patches
		pkgdb -F
		portupgrade -a
		exit
		;;
	"8")
		update
		marcusmerge -x
		patches
		pkgdb -F
		portupgrade -a
		exit
		;;
	"9")
		clean
		update
		patches
		prime
		exit
		;;
	*)
		clean
		update
		patches
		prime
		install_new
		marcusmerge ${expargs}
		upgrade
		exit
		;;
esac

echo "Here there be tacos"
