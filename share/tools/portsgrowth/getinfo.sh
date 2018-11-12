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
awk '$1 ~ /^revision/ {
        print $2
        next
     }
     $1 ~ /^date/ {
        print $2 " " substr($3, 1, length($3)-1)
        next
     }' |
while read rev ; do
  read date
  grep "$date" ports.log > /dev/null 2>&1
  if [ $? = 1 ]; then
    echo $date
    $CVSCMD up -r "$rev" $INDEX
    echo $date $(wc -l < $INDEX) >> ports.log1
  fi
done 

# Remove dupes.
sort -u ports.log1 > ports.log

# Cleanup
rm ports.log1
rm -r ports

