#! /bin/sh -e

# Get a linecount for all the revisions listed in 'cvs log' and append
# to our current list.  This lets us keep info for revisions that have
# been axed from the repository.
cvs log /usr/ports/INDEX | 
sed -ne "s/^date: \([^;]*\);.*$/\1/p" |
while read date ; do
 echo $date
 cvs update -D "$date" /usr/ports/INDEX
 echo $date $(wc -l < /usr/ports/INDEX) >> ports.log
done 
# Put INDEX back the way we found it.
cvs update -A /usr/ports/INDEX

# Remove dupes.
sort -u ports.log > ports.log1
mv ports.log1 ports.log

# Generate graph.
gnuplot ports.plt

# Interlace.
pngtopnm ports.png | pnmtopng -i > ports.png1
mv ports.png1 ports.png
