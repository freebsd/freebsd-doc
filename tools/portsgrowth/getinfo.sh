#!/bin/sh -ex
#
# Refresh source file used for ploting ports growth status.
#
# Get an information about all revisions listed in 'cvs log' and merge
# it with our current list. This lets us keep info about revisions that
# have been axed from the repository during ports/INDEX cleanup.
#
# $FreeBSD$

CVSCMD='cvs -QR'
INDEX=ports/INDEX

echo "*** Refreshing ports.log status"
cp ports.log ports.log1

$CVSCMD co $INDEX

$CVSCMD log $INDEX | 
sed -ne "s/^date: \([^;]*\);.*$/\1/p" |
while read date ; do
  grep "$date" ports.log > /dev/null 2>&1
  if [ $? = 1 ]; then
    echo $date
    $CVSCMD up -D "$date" $INDEX
    echo $date $(wc -l < $INDEX) >> ports.log1
  fi
done 

# Remove dupes.
sort -u ports.log1 > ports.log

# Cleanup
rm ports.log1
rm -r ports

