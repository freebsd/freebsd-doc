#!/usr/bin/perl -w
# $FreeBSD$

use strict;

while (<>) {
        next unless (m,^(.*/)([\w\._-]+)\.(\d\w*)(\.gz)?$,);
        my ($entity, $page, $volume) = ($2, $2, $3);
        $entity =~ y/_/./;
        print "<!ENTITY man.$entity.$volume \"<citerefentry xmlns='http://docbook.org/ns/docbook'><refentrytitle>$page</refentrytitle><manvolnum>$volume</manvolnum></citerefentry>\">\n";
}
