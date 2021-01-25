#!/bin/sh
#

progname=$(basename $(realpath $0))

# Print an informational message
info() {
	echo "$@" >&2
}

# Print a warning message
warning() {
	echo "WARNING: $@" >&2
}

# Print an error message and exit
error() {
	echo "ERROR: $@" >&2
	exit 1
}

# Print usage message and exit
usage() {
	echo "usage: ${progname} [user] [keyid ...]\n" >&2
	exit 1
}

# Look for gpg
gpg=$(which gpg)
if [ -z "${gpg}" -o ! -x "${gpg}" ] ; then
	error "gpg does not seem to be installed"
fi
gpg() {
	LANG=C "${gpg}" \
	    --display-charset utf-8 \
	    --no-greeting \
	    --no-secmem-warning \
	    --keyid-format long \
	    --list-options no-show-uid-validity \
	    "$@"
}

# Look up key by key ID
getkeybyid() {
	gpg --with-colons --list-keys "$1" 2>/dev/null | awk -F: \
	    '$5 ~ /^\([0-9A-F]{8}\)?'"$1"'$/i && $12 ~ /ESC/ { print $5 }'
}

# Look up key by email
getkeybyemail() {
	gpg --with-colons --list-keys "$1" 2>/dev/null | awk -F: \
	    '$10 ~ /<'"$1"'>/i && $12 ~ /ESC/ { print $5 }'
}

# The first command-line argument can be a user name or a key ID.
if [ $# -gt 0 ] && expr "$1" : '^[a-z][0-9a-z-]*$' >/dev/null ; then
	me="$1"
	shift
fi
if [ -z "${me}" ] ; then
	me=$(id -nu)
fi
if [ -z "${me}" ] ; then
	error "Unable to determine user name."
fi
if ! expr "${me}" : '^[0-9a-z][0-9a-z-]*$' >/dev/null ; then
	error "${me} does not seem like a valid user name."
fi

if [ $# -ne 0 ] ; then
	# Verify the keys that were specified on the command line
	for arg ; do
		case $(expr "${arg}" : '^[0-9A-Fa-f]\{8,16\}$') in
		8)
			warning "${arg}: recommend using 16-digit keyid"
			;&
		16)
			keyid=$(getkeybyid "${arg}")
			if [ -n "${keyid}" ] ; then
				keyids="${keyids} ${keyid}"
			else
				warning "${arg} not found"
			fi
			;;
		*)
			warning "${arg} does not appear to be a valid key ID"
			;;
		esac
	done
else
	# Search for keys by freebsd.org email
	email="${me}@FreeBSD.org"
	keyids=$(getkeybyemail "${email}")
	case $(echo "${keyids}" | wc -w) in
	0)
		error "no keys found for ${email}"
		;;
	1)
		;;
	*)
		warning "Multiple keys found for <${email}>; exporting all."
		warning "If this is not what you want, specify a key ID" \
		    "on the command line."
		;;
	esac
fi

# :(
if [ -z "${keyids}" ] ; then
	error "no valid keys were found"
fi

# Generate key file
keyfile="${me}.key"
info "Generating ${keyfile}..."
(
    echo '<!--'
    echo "sh ${progname} ${me}" ${keyids} ";"
    echo '-->'
    echo '<programlisting xmlns="http://docbook.org/ns/docbook" role="pgpfingerprint"><![CDATA['
    gpg --fingerprint ${keyids}
    echo ']]></programlisting>'
    echo '<programlisting xmlns="http://docbook.org/ns/docbook" role="pgpkey"><![CDATA['
    gpg --no-version --armor --export ${keyids}
    echo ']]></programlisting>'
) >"${keyfile}"

info "Adding key to entity list..."
if ! grep -qwF "pgpkey.${me}" pgpkeys.ent ; then
	mv pgpkeys.ent pgpkeys.ent.orig || exit 1
	(
		cat pgpkeys.ent.orig
		echo "<!ENTITY pgpkey.${me} SYSTEM \"${keyfile}\">"
	) | sort -u >pgpkeys.ent
fi

cat <<EOF

Unless you are already listed there, you should now add the following
text to pgpkeys-developers.xml.  Remember to keep the list sorted by
last name!

    <sect2 xmlns="http://docbook.org/ns/docbook" xml:id="pgpkey-${me}">
      <title>&a.${me}.email;</title>
      &pgpkey.${me};
    </sect2>

If this is a role key or you are a core member, you should add it to
either pgpkeys-officers.xml or pgpkeys-core.xml instead.

If this is a new entry, don't forget to run the following commands
before committing:

% git add ${keyfile}

EOF
