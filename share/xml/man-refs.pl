#!/usr/bin/perl -w
# $FreeBSD$
#
# To get the entities sorted the same way as the current man-refs.ent file is, this command can be used:
#
# find -s /usr/share/man/ -name '*.gz' | \
#   sed -Ee 's,.*([[:digit:]])/(.*)\.[^.]+\.gz,\1 \2 &,' | \
#   env LANG=C sort -k 1,1n -k 2,2 | \
#   sed -e 's/.* //' | \
#   perl share/xml/man-refs.pl

use strict;

while (<>) {
        next unless (m,^(.*/)([\w\._-]+)\.(\d\w*)(\.gz)?$,);
        my ($entity, $page, $volume) = ($2, $2, $3);
        $entity =~ y/_/./;
        print "<!ENTITY man.$entity.$volume \"<citerefentry xmlns='http://docbook.org/ns/docbook'><refentrytitle>$page</refentrytitle><manvolnum>$volume</manvolnum></citerefentry>\">\n";
}
