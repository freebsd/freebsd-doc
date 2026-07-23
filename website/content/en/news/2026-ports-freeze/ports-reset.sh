#!/bin/sh -e

# Note that the hash of this file is recorded in a signed announcement, please
# do not touch it without due consideration.

cleanup() {
	rc=$?

	if [ -n "$tmpf" ]; then
		rm -f "$tmpf"
		rm -f "$tmpf.import"
	fi

	exit "$rc"
}

me=${0##*/}
tmpf=$(mktemp -t ports-reset)
trap cleanup EXIT

#
# REPLACE AS NEEDED:
#
# bad1 and bad2 correspond to the following two commits.  If your tree or branch
# has local changes mixed in, confirm and replace the commits with your
# equivalent:
#
# commit bb14266f00bb1bac62900477b93e5a7be984cd2f
# Date:   Mon Jul 20 22:03:39 2026 -0000
#
#    misc/github-copilot-cli: update 1.0.71 → 1.0.72
#
# commit f208eb093cebb71adaec5861c76c8369139289d2
# Date:   Tue Jul 21 05:00:50 2026
#
#    misc/github-copilot-cli: Remove inadvertently added file
#
bad1=bb14266f00bb1bac62900477b93e5a7be984cd2f
bad2=f208eb093cebb71adaec5861c76c8369139289d2
dry_run=
if [ $# -gt 0 ]; then
	if [ $1 = "-h" ]; then
		echo "Usage: $me [-h] [-n] [bad_hash1] [bad_hash2]"
		echo "$me should be invoked while the ports repository to be fixed is the current working directory"
		echo "bad_hash1 and bad_hash2 must be ordered exactly as they appear in commit history, with bad_hash1 being older"
		exit 0
	fi
	if [ $1 = "-n" ]; then
		dry_run=echo
		shift
	fi
fi
if [ $# -gt 0 ]; then
	bad1="$1"
	shift
fi
if [ $# -gt 0 ]; then
	bad2="$1"
	shift
fi

filter="$bad1|$bad2"

# We use git-fast-export to dump all of the revisions that need to be replayed.
# We dump one revision before the first bad revision to be dropped because the
# first revision in the dump is magic to git-fast-export.
# Note that any commit signatures in the commits to be rewritten will be removed
# by this operation.  This makes it reproducible.
/usr/local/bin/git fast-export \
	--show-original-ids \
	--signed-tags=strip \
	--reference-excluded-parents \
	--no-data \
	--mark-tags \
	--use-done-feature \
	${bad1}~2..HEAD \
	> "$tmpf"

# Sanity check: did we have the commit in the first place?
if ! grep -q "original-oid $bad1" "$tmpf"; then
	1>&2 echo "This branch does not seem to contain the commit that needs to be pruned."
	1>&2 echo "Please refer to the comments in '$0' for adjustments that may need to be made."
	1>&2 echo "Bailing out without modifying the current branch."
	exit 1
fi

/usr/bin/sed -En '
/^from :/d
H
/^$/!{
	$!d
}
x
/original-oid ('$filter')/!{
	s/^\n//
	p
}' < "$tmpf" > "$tmpf.import"

if [ -n "$dry_run" ]; then
	echo Would have issued: /usr/local/bin/git fast-import --force --date-format=raw \< "$tmpf.import"
	echo "Commits dropped can be inspected in the following somewhat noisy diff:"
	echo diff -u "$tmpf" "$tmpf.import"
	trap - EXIT
else
	/usr/local/bin/git fast-import --force --date-format=raw < "$tmpf.import"
	# git-fast-import leaves the contents of the bad commits in the index.
	# Clean up to avoid accidents.
	git checkout HEAD .

	# This shouldn't happen, but we'd rather be safe than sorry.
	echo "Please review your tree for any staged changes that may have been left behind."
fi
