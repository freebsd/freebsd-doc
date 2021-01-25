#!/bin/sh
#
# $FreeBSD$
#

#
# This script is intended to sanity-check PGP keys used by folks with
# @FreeBSD.org email addresses.  The checks are intended to be derived
# from the information at
# <https://riseup.net/en/security/message-security/openpgp/gpg-best-practices#openpgp-key-checks>
#

# make sure we are in a well known language
LANG=C

\unalias -a

progname=${0##*/}

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
if [ $? -gt 0 -o -z "${gpg}" -o ! -x "${gpg}" ] ; then
	error "Cannot find gpg"
fi

# Set up our internal default gpg invocation options
_gpg() {
	${gpg} \
	    --display-charset utf-8 \
	    --no-greeting \
	    --no-secmem-warning \
	    --keyid-format long \
	    --list-options no-show-uid-validity \
	    "$@"
}

# Look up key by key ID
getkeybyid() {
	_gpg --with-colons --list-keys "$1" 2>/dev/null | awk -F: \
	    '$5 ~ /^\([0-9A-F]{8}\)?'"$1"'$/i && $12 ~ /ESC/ { print $5 }'
}

# Look up key by email
getkeybyemail() {
	_gpg --with-colons --list-keys "$1" 2>/dev/null | awk -F: \
	    '$10 ~ /<'"$1"'>/i && $12 ~ /ESC/ { print $5 }'
}

# The first command-line argument can be a user name or a key ID.
if [ $# -gt 0 ] ; then
	id="$1"
	shift
else
	id=$(id -nu)
	warning "No argument specified, calculating user ID"
fi

# Now let's try to figure out what kind of thing we have as an ID.
#  We'll check for a keyid first, as it's readily distinguishable
#  from other things, but if we see that we have one, we push it back
#  onto the argument list for later processing (becasue we may have
#  been given a list of keyods).
if echo "${id}" | egrep -q '^[0-9A-F]{16}$'; then
	id_type="keyid"
	set -- "${id}" $@
elif echo "${id}" | egrep -q '^[0-9A-F]{8}$'; then
	id_type="keyid"
	set -- "${id}" $@
elif echo "${id}" | egrep -iq '^[a-z][-0-9a-z_]*@([-0-9a-z]+\.)[-0-9a-z]+$'; then
	id_type="email"
	email="${id}"
elif echo "${id}" | egrep -iq '^[a-z][-0-9a-z_]*$'; then
	id_type="login"
	login="${id}"
	email="${id}@FreeBSD.org"
else
	error "Cannot recognize type of ${id} (keyid, login, or email)"
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
		shift
	done
else
	# Search for keys by freebsd.org email
	keyids=$(getkeybyemail "${email}")
	case $(echo "${keyids}" | wc -w) in
	0)
		error "no keys found for ${email}"
		;;
	1)
		;;
	*)
		warning "Multiple keys found for <${email}>; checking all."
		warning "If this is not what you want, specify a key ID" \
		    "on the command line."
		;;
	esac
fi

# :(
if [ -z "${keyids}" ] ; then
	error "no valid keys were found"
fi

# add a problem report to the list of problems with this key
badkey() {
	key_problems="        ${key_problems}$@
"
}

exitstatus=0

# Check the keys
for key in ${keyids} ; do
	# no problems found yet
	key_problems=""

	IFS_save="${IFS}"
	key_info=$( ${gpg} --no-secmem-warning --export-options export-minimal --export ${key} \
		| ${gpg} --no-secmem-warning --list-packets )
	# primary keys should be RSA or DSA-2
	IFS=""
	version=$( echo $key_info | \
		awk '$1 == "version" && $3 == "algo" {sub(",", "", $2); print $2; exit 0}' )
	IFS="${IFS_save}"
	if [ $version -lt 4 ]; then
		badkey "This key is a deprecated version $version key!"
	fi

	IFS=""
	algonum=$( echo $key_info | \
		awk '$1 == "version" && $3 == "algo" {sub(",", "", $4); print $4; exit 0}' )
	IFS="${IFS_save}"
	case ${algonum} in
		"1")	algo="RSA" ;;
		"17")	algo="DSA" ;;
		"18")	algo="ECC" ;;
		"19")	algo="ECDSA" ;;
		*)	algo="*UNKNOWN*" ;;
	esac

	IFS=""
	bitlen=$( echo $key_info | \
		awk -F : '$1 ~ "pkey" { gsub("[^0-9]*","", $2); print $2; exit 0}' )
	IFS="${IFS_save}"
	echo "key ${key}: ${algo}, ${bitlen} bits"
	case ${algo} in
		RSA)	;;
		DSA)	if [ "${bitlen}" -le 1024 ]; then \
				badkey "DSA, but not DSA-2"; \
			fi ;;
		*)	badkey "non-preferred algorithm"
	esac

	# self-signatures must not use MD5 or SHA1
	IFS=""
	sig_algonum=$( echo $key_info | \
		awk '$1 == "digest" && $2 == "algo" {sub(",", "", $3); print $3; exit 0}' )
	IFS="${IFS_save}"
	case sig_algonum in
		1) sigs="MD5";;
		2) sigs="SHA1";;
		3) sigs="RIPEMD160";;
		8) sigs="SHA256";;
		9) sigs="SHA384";;
		10) sigs="SHA512";;
		11) sigs="SHA224";;
		*)
	esac
	for sig in ${sigs}; do
		if [ "${sig}" = "MD5" -o "${sig}" = "SHA1" ]; then
			badkey "self-signature ${sig}"
		fi
	done

	# digest algo pref must include at least one member of SHA-2
	# at a higher priority than both MD5 and SHA1
	IFS=""
	algopref=$( echo $key_info | \
		awk -F : '$1 ~ "pref-hash-algos" {gsub("[^ 0-9]", "", $2); print $2; exit 0}' )
	IFS="${IFS_save}"
	# if 3, 2, or 1 are before 11, 10, 9, or 8, then
	set -- ${algopref}
	if [ $1 -lt 4 ]; then
		badkey "algorithm prefs do not have SHA-2 higher than MD5 or SHA1"
	fi

	# primary keys should have an expiration date at least a year
	# in the future to make them worth committing, but no more
	# than three years in the future
	expires=$( _gpg --list-keys ${key} | \
		awk "/$keyid .*expires:/ {sub(\"[^-0-9]\", \"\", \$NF); print \$NF; exit 0}" )
	if [ -z "${expires}" ]; then
		badkey "this key does not expire"
	else
		expires_s=$( date -jf "%F" "+%s" "${expires}" )
		now_s=$( date "+%s" )
		# 86400 == # seconds in a normal day
		expire_int_d=$(( ( ${expires_s} - ${now_s} ) / 86400 ))
		exp_min=$(( 1 * 365 ))		# Min expiry time is 1 year
		exp_max=$(( 3 * 365 + 1 ))	# Max expiry time is 3 years
						# We add 1 day because in a 3-year
						# period, probability of a leap day
						# is 297/400, about 0.74250
		if [ ${expire_int_d} -lt ${exp_min} ]; then
			badkey "Key $key expires in less than 1 year ($expire_int_d days)"
		fi
		if [ ${expire_int_d} -gt ${exp_max} ]; then
			badkey "Key $key expires in more than 3 years ($expire_int_d days)"
		fi
	fi

	# report problems
	if [ -z "${key_problems}" ]; then
		echo "    key okay, ${key} meets minimal requirements" >&2
	else
		exitstatus=1
		echo "    ** problems found:" >&2
		echo "${key_problems}" >&2
		echo "    ** key ${key} should not be used!"
	fi
	echo
done
exit ${exitstatus}
