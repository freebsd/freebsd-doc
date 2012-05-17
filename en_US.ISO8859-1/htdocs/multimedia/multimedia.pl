#!/usr/bin/perl -w

#
# $Id: multimedia.pl,v 1.6 2008-12-07 06:12:06 edwin Exp $
# $FreeBSD: www/en/multimedia/multimedia.pl,v 1.5 2008/12/06 06:25:37 hrs Exp $
#

use strict;
use XML::Parser;
use Data::Dumper;
use POSIX;
use IO::File;

my @months = (
    "", "January", "February", "March",
    "April", "May", "June", "July",
    "August", "September", "October",
    "November", "December"
);

my @createdhtml = ();
my @createdsgml = ();
my @createdxml = ();

my @tree = ();
my @values = ();
my $treeindex = -1;

my @items;
my $ci = -1;
my %sources;
my $sid = "";
my %tags;
my $tag = "";

sub addtags {
    my $tags = shift;

    if ($tags) {
	my @w = split(/,/, $tags);
	foreach my $w (@w) {
	    $tags{$w} = 0 if (!defined $tags{$w});
	    $tags{$w}++;
	}
	return;
    }

    my $array = shift;
    my @array = @{$array};
    foreach my $w (@array) {
	$tags{$w} = 0 if (!defined $tags{$w});
	$tags{$w}++;
    }
}

sub xml_start {
    my $expat = shift;
    my $element = shift;

    $tree[++$treeindex] = $element;
    while (defined (my $attribute = shift)) {
	$values[$treeindex]{$attribute} = shift;
    }

    if ($element eq "item"
     && $treeindex == 2) {
	$ci++;
	$items[$ci] = ();
	$items[$ci]{source} = $values[$treeindex]{source};
	$items[$ci]{added} = $values[$treeindex]{added};
	$items[$ci]{ci} = $ci;
	$items[$ci]{fc} = -1;
    }

    if ($element eq "source"
     && $treeindex == 2) {
	$sid = $values[$treeindex]{id};
	$sources{$values[$treeindex]{id}} = ();
    }

    if ($element eq "url"
     && $treeindex == 5) {
	$items[$ci]{fc}++;
    }

    if ($treeindex == 3 &&
	$element eq "tags") {
	$tag = "";
    }
}

sub xml_end {
    my $expat = shift;
    my $element = shift;

    if ($treeindex == 3 &&
	$element eq "tags") {
	@{$items[$ci]{tags}} = split(/,/, $tag);
	addtags($tag);
    }

    $values[$treeindex] = ();
    $treeindex--;
}

sub xml_char {
    my $expat = shift;
    my $value = shift;

    if ($tree[0] eq "multimedia") {
	return if ($treeindex == 0);

	if ($tree[1] eq "items") {
	    return if ($treeindex == 1);

	    if ($tree[2] eq "item") {
		return if ($treeindex == 2);

		if ($tree[3] eq "title") {
		    $items[$ci]{title} = "" if (!defined $items[$ci]{title});
		    $items[$ci]{title} .= $value;
		    return;
		}
		if ($tree[3] eq "desc") {
		    $items[$ci]{desc} = "" if (!defined $items[$ci]{desc});
		    $items[$ci]{desc} .= $value;
		    return;
		}
		if ($tree[3] eq "overview") {
		    $items[$ci]{overview} = "" if (!defined $items[$ci]{desc});
		    $items[$ci]{overview} .= $value;
		    return;
		}
		if ($tree[3] eq "link") {
		    $items[$ci]{link} = "" if (!defined $items[$ci]{link});
		    $items[$ci]{link} .= $value;
		    return;
		}
		if ($tree[3] eq "tags") {
		    $tag .= $value;
		    return;
		}

		if ($tree[3] eq "files") {
		    return if ($treeindex == 3);

		    if ($tree[4] eq "prefix") {
			$items[$ci]{prefix} = "" if (!defined $items[$ci]{prefix});
			$items[$ci]{prefix} .= $value;
			return;
		    }

		    if ($tree[4] eq "file") {
			return if ($treeindex == 4);

			if ($tree[5] eq "url") {
			    # Note that $items[$ci]{fc} gets incremented in xml_start
			    $items[$ci]{files}{$items[$ci]{fc}}{url} = ""
				if (!defined $items[$ci]{files}{$items[$ci]{fc}}{url});
			    $items[$ci]{files}{$items[$ci]{fc}}{url} .= $value;
			    return;
			}
			if ($tree[5] eq "size") {
			    $items[$ci]{files}{$items[$ci]{fc}}{size} = ""
				if (!defined $items[$ci]{files}{$items[$ci]{fc}}{size});
			    $items[$ci]{files}{$items[$ci]{fc}}{size} .= $value;
			    return;
			}
			if ($tree[5] eq "length") {
			    $items[$ci]{files}{$items[$ci]{fc}}{length} = ""
				if (!defined $items[$ci]{files}{$items[$ci]{fc}}{length});
			    $items[$ci]{files}{$items[$ci]{fc}}{length} .= $value;
			    return;
			}
			if ($tree[5] eq "desc") {
			    $items[$ci]{files}{$items[$ci]{fc}}{desc} = ""
				if (!defined $items[$ci]{files}{$items[$ci]{fc}}{desc});
			    $items[$ci]{files}{$items[$ci]{fc}}{desc} .= $value;
			    return;
			}
			if ($tree[5] eq "tags") {
			    @{$items[$ci]{files}{$items[$ci]{fc}}{tags}} = split(/,/, $value);
			    addtags($value);
			    addtags("", $items[$ci]{tags});
			    return;
			}
			goto error;
		    }
		    goto error;
		}
		goto error;
	    }
	    goto error;
	}

	if ($tree[1] eq "sources") {
	    return if ($treeindex == 1);

	    if ($tree[2] eq "source") {
		return if ($treeindex == 2);

		if ($tree[3] eq "name") {
		    $sources{$sid}{name} = $value;
		    return;
		}
		if ($tree[3] eq "url") {
		    $sources{$sid}{url} = $value;
		    return;
		}
		goto error;
	    }
	    goto error;
	}
	goto error;
    }

error:
    print "Unknown item at depth $treeindex: $tree[$treeindex]\n";
}

my $p = new XML::Parser(
    Handlers => {
	Start	=> \&xml_start,
	End	=> \&xml_end,
	Char	=> \&xml_char,
    }
);
$p->parsefile("multimedia-input.xml");

my @site_order = ();
{
    sub site_sort {
	my %a = %{$a};
	my %b = %{$b};
	return $a{source} cmp $b{source}
	    if ($a{source} ne $b{source});
	return $a{title} cmp $b{title};
    }
    @site_order = sort site_sort @items;
}

my @date_order = ();
{
    my %dates = ();
    foreach my $item (@items) {
	my %item = %{$item};
	$dates{$item{ci}} = $item{added};
    }
    my @dates = keys(%dates);
    @date_order = sort { $dates{$b} cmp $dates{$a} } @dates;
}

#
# HTML overview output
#
sub print_htmlitem {
    my $fhandle = shift;
    my $item = shift;
    my %item = %{$item};
    my $source = shift;
    my %source = %{$source};

    print $fhandle "<li><p>";
    if (defined $item{overview}) {
	print $fhandle "<a href=\"", htmlentities($item{overview}), "\">$item{title}</a>\n";
    } else {
	my %media = %{$item{files}{0}};
	print $fhandle "<a href=\"", htmlentities($media{url}), "\">$item{title}</a>\n";
	if (defined $media{size} || defined $media{length}) {
	    my $s = "";
	    print $fhandle "(";
	    if (defined $media{size}) {
		print $fhandle "$media{size}";
		$s = ", ";
	    }
	    if (defined $media{length}) {
		print $fhandle "$s$media{length}";
		$s = ", ";
	    }
	    print $fhandle ")";
	}
    }
    print $fhandle "<br>Source: <a href=\"", htmlentities($source{url}), "\">",
	$source{name}, "</a><br>\n";
    print $fhandle "Added: ",
	    substr($item{added}, 6, 2), " ",
	    $months[substr($item{added}, 4, 2)], " ",
	    substr($item{added}, 0, 4), "<br>\n";

    print $fhandle "Tags: ";
    {
	my $first = 1;
	foreach my $t (@{$item{tags}}) {
	    print $fhandle ", " if (!$first);
#	    join(", ", @{$item{$t}}), "<br>\n";
	    my $th = $t;
	    $th =~ s/ /_/g;
	    print $fhandle "<a href=\"tag-$th.html\">$t</a>";
	    $first = 0;
	}
    }
    print $fhandle "<br>\n";

    if (defined $item{overview} && defined $item{files}) {
	my $c = 0;
	foreach my $m (keys(%{$item{files}})) {
	    my %file = %{$item{files}{$m}};
	    print $fhandle ", " if ($c++);
	    if (defined $item{prefix}) {
		print $fhandle "<a href=\"" . htmlentities($item{prefix} . "/" . $file{url}) . "\">$file{desc}</a>";
	    } else {
		print $fhandle "<a href=\"" . htmlentities($file{url}) . "\">$file{desc}</a>";
	    }
	    if (defined $file{size} || defined $file{length}) {
		my $s = "";
		print $fhandle " (";
		if (defined $file{size}) {
		    print $fhandle "$file{size}";
		    $s = ", ";
		}
		if (defined $file{length}) {
		    print $fhandle "$s$file{length}";
		    $s = ", ";
		}
		print $fhandle ")";
	    }
	}
	print $fhandle "<br>\n";
    }
    print $fhandle "</p>\n";
    print $fhandle "$item{desc}\n";
    print $fhandle "</li>\n";
}
{
    $createdhtml[$#createdhtml+1] = "multimedia.html";
    $createdsgml[$#createdsgml+1] = "multimedia.sgml";
    my $fhtml = new IO::File;
    my $fsgml = new IO::File;

    open($fhtml, ">multimedia.html");
    open(FIN, "multimedia.html.pre");
    my @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    open(FIN, "multimedia.html.intro");
    @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    print $fhtml "<h2 id=\"latest\">Newest resources</h2>\n";

    open($fsgml, ">multimedia.sgml");
    open(FIN, "multimedia.sgml.pre");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    open(FIN, "multimedia.sgml.intro");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    print $fsgml "<h2 id=\"latest\">Newest resources</h2>\n";

    my $month = "";

    foreach my $order (@date_order) {
	my %item = %{$items[$order]};
	my %source = %{$sources{$item{source}}};
	if (substr($item{added}, 0, 6) ne $month) {
	    if ($month ne "") {
		print $fhtml "</ul>\n";
		print $fsgml "</ul>\n";
	    }
	    print $fhtml "<h2>", $months[substr($item{added}, 4, 2)+0], " ", substr($item{added}, 0, 4), "</h2><ul>";
	    print $fsgml "<h2>", $months[substr($item{added}, 4, 2)+0], " ", substr($item{added}, 0, 4), "</h2><ul>";
	    $month = substr($item{added}, 0, 6);
	}

	print_htmlitem($fhtml, \%item, \%source);
	print_htmlitem($fsgml, \%item, \%source);
    }

    print $fhtml "</ul>\n";
    open(FIN, "multimedia.html.post");
    @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    close($fhtml);

    print $fsgml "</ul>\n";
    open(FIN, "multimedia.sgml.post");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    close($fsgml);
}

#
# HTML cloud output
#
{
    $createdhtml[$#createdhtml+1] = "tags.html";
    $createdsgml[$#createdsgml+1] = "tags.sgml";
    my $fhtml = new IO::File;
    my $fsgml = new IO::File;
    open($fhtml, ">tags.html");
    open($fsgml, ">tags.sgml");

    open(FIN, "multimedia.html.pre");
    my @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    open(FIN, "multimedia.html.intro");
    @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    print $fhtml "<h2 id=\"latest\">Tags</h2>\n";

    open(FIN, "multimedia.sgml.pre");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    open(FIN, "multimedia.sgml.intro");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    print $fsgml "<h2 id=\"latest\">Tags</h2>\n";

    my $month = "";

    sub size {
	return $b cmp $a if ($tags{$b} == $tags{$a});
	return $tags{$b} <=> $tags{$a};
    }
    my $size = 20;
    my $c = 0;
    foreach my $tag (sort size(keys(%tags))) {
	my $ftag = $tag;
	$ftag =~ s/ /_/g;
	print $fhtml "<font style=\"font-size:${size}pt\"><a href=\"tag-$ftag.html\">$tag</a></font>\n";
	print $fsgml "<font style=\"font-size:${size}pt\"><a href=\"tag-$ftag.html\">$tag</a></font>\n";
	$size-- if ($c++%10 == 0 && $size > 2);
    }

    open(FIN, "multimedia.html.post");
    @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;

    open(FIN, "multimedia.sgml.post");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;

    close($fhtml);
    close($fsgml);
}

#
# HTML per-tags output
#
{
    foreach my $tag (keys(%tags)) {
	my $fhtml = new IO::File;
	my $fsgml = new IO::File;

	my $ftag = $tag;
	$ftag =~ s/ /_/g;
	$createdhtml[$#createdhtml+1] = "tag-$ftag.html";
	$createdsgml[$#createdsgml+1] = "tag-$ftag.sgml";
	open($fhtml, ">tag-$ftag.html");
	open($fsgml, ">tag-$ftag.sgml");

	open(FIN, "multimedia.html.pre");
	my @lines = <FIN>;
	close(FIN);
	print $fhtml @lines;
	open(FIN, "multimedia.html.intro");
	@lines = <FIN>;
	close(FIN);
	print $fhtml @lines;
	print $fhtml "<h2 id=\"latest\">Tag: $tag</h2>\n";
	print $fhtml "<ul>\n";

	open(FIN, "multimedia.sgml.pre");
	@lines = <FIN>;
	close(FIN);
	print $fsgml @lines;
	open(FIN, "multimedia.sgml.intro");
	@lines = <FIN>;
	close(FIN);
	print $fsgml @lines;
	print $fsgml "<h2 id=\"latest\">Tag: $tag</h2>\n";
	print $fsgml "<ul>\n";

	foreach my $item (@items) {
	    my %item = %{$item};
	    my %source = %{$sources{$item{source}}};

	    my $found = 0;

	    foreach my $itag (@{$item{tags}}) {
		if ($itag eq $tag) {
		    $found = 1;
		    last;
		}
	    }

	    if (!$found) {
		foreach my $file (keys(%{$item{files}})) {
		    my %file = %{$item{files}{$file}};
		    foreach my $itag (@{$file{tags}}) {
			if ($itag eq $tag) {
			    $found = 1;
			    last;
			}
		    }
		}
	    }

	    print_htmlitem($fhtml, \%item, \%source) if ($found);
	    print_htmlitem($fsgml, \%item, \%source) if ($found);

	}

	print $fhtml "</ul>\n";
	open(FIN, "multimedia.html.post");
	@lines = <FIN>;
	close(FIN);
	print $fhtml @lines;
	close($fhtml);

	print $fsgml "</ul>\n";
	open(FIN, "multimedia.sgml.post");
	@lines = <FIN>;
	close(FIN);
	print $fsgml @lines;
	close($fsgml);

    }
}

#
# HTML all-sources output
#
{
    my $fhtml = new IO::File;
    my $fsgml = new IO::File;

    $createdhtml[$#createdhtml+1] = "sources.html";
    $createdsgml[$#createdsgml+1] = "sources.sgml";
    open($fhtml, ">sources.html");
    open($fsgml, ">sources.sgml");

    open(FIN, "multimedia.html.pre");
    my @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    open(FIN, "multimedia.html.intro");
    @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    print $fhtml "<h2 id=\"latest\">Sources</h2>\n";
    print $fhtml "<ul>\n";

    open(FIN, "multimedia.sgml.pre");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    open(FIN, "multimedia.sgml.intro");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    print $fsgml "<h2 id=\"latest\">Sources</h2>\n";
    print $fsgml "<ul>\n";

    my $lastsource = "";
    foreach my $item (@site_order) {
	my %item = %{$item};
	next if ($lastsource eq $item{source});
	$lastsource = $item{source};

	print $fhtml "<li><a href=\"source-$lastsource.html\">", $sources{$item{source}}{name}, "</a>\n";
	print $fsgml "<li><a href=\"source-$lastsource.html\">", $sources{$item{source}}{name}, "</a>\n";
    }

    print $fhtml "</ul>\n";
    open(FIN, "multimedia.html.post");
    @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    close($fhtml);

    print $fsgml "</ul>\n";
    open(FIN, "multimedia.sgml.post");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    close($fsgml);

}

#
# HTML per-source output
#
{
    my $fhtml = new IO::File;
    my $fsgml = new IO::File;

    my $lastsource = "";
    foreach my $item (@site_order) {
	my %item = %{$item};
	my %source = %{$sources{$item{source}}};
	if ($lastsource ne $item{source}) {

	    if ($lastsource) {
		print $fhtml "</ul>\n";
		print $fsgml "</ul>\n";

		open(FIN, "multimedia.html.post");
		my @lines = <FIN>;
		close(FIN);
		print $fhtml @lines;
		close($fhtml);

		open(FIN, "multimedia.sgml.post");
		@lines = <FIN>;
		close(FIN);
		print $fsgml @lines;
		close($fsgml);

	    }
	    $createdhtml[$#createdhtml+1] = "source-$item{source}.html";
	    $createdsgml[$#createdsgml+1] = "source-$item{source}.sgml";
	    open($fhtml, ">source-$item{source}.html");
	    open($fsgml, ">source-$item{source}.sgml");

	    open(FIN, "multimedia.html.pre");
	    my @lines = <FIN>;
	    close(FIN);
	    print $fhtml @lines;
	    open(FIN, "multimedia.html.intro");
	    @lines = <FIN>;
	    close(FIN);
	    print $fhtml @lines;

	    open(FIN, "multimedia.sgml.pre");
	    @lines = <FIN>;
	    close(FIN);
	    print $fsgml @lines;
	    open(FIN, "multimedia.sgml.intro");
	    @lines = <FIN>;
	    close(FIN);
	    print $fsgml @lines;

	    $lastsource = $item{source};
	    print $fhtml "<h2 id=\"latest\">$source{name}</h2>\n<ul>\n";
	    print $fsgml "<h2 id=\"latest\">$source{name}</h2>\n<ul>\n";
	}
	print_htmlitem($fhtml, \%item, \%source);
	print_htmlitem($fsgml, \%item, \%source);

    }
    print $fhtml "</ul>\n";
    print $fsgml "</ul>\n";

    open(FIN, "multimedia.html.post");
    my @lines = <FIN>;
    close(FIN);
    print $fhtml @lines;
    close($fhtml);

    open(FIN, "multimedia.sgml.post");
    @lines = <FIN>;
    close(FIN);
    print $fsgml @lines;
    close($fsgml);
}

#
# XML output
#
{

    sub htmlentities {
	my $s = shift;
	$s =~ s/&/&amp;/g;
	$s =~ s/</&lt;/g;
	$s =~ s/>/&gt;/g;
	return $s;;
    }
    sub printxml_multiple {
	my $item = shift;
	my %item = %{$item};
	my $source = shift;
	my %source = %{$source};
	
	return if ($item{fc}<0);

	for (my $i = 0; $i <= $item{fc}; $i++) {
	    my %f = %{$item{files}{$i}};

	    my %tempitem = %item;
	    $tempitem{title} .= " - $f{desc}";
	    $f{url} = "$item{prefix}/$f{url}"
		if (defined $item{prefix});
	    printxml_single(\%tempitem, \%source, \%f);
	}
    }

    sub printxml_single {
	my $item = shift;
	my %item = %{$item};
	my $source = shift;
	my %source = %{$source};
	my $file = shift;
	my %file = %{$file};

	my $date = POSIX::strftime("%a, %d %b %Y %H:%M:%S %Z",
	    0, 0, 0, substr($item{added}, 6, 2),
	    substr($item{added}, 4, 2)-1, substr($item{added}, 0, 4)-1900);

	my $tags = join(", ", @{$item{tags}});
	foreach my $tag (@{$file{tags}}) {
	    $tags .= ", $tag";
	}

	print FOUT "<item>\n";
	print FOUT "<title>", htmlentities("$source{name} - $item{title}"), "</title>\n";
	print FOUT "<guid>", htmlentities($file{url}), "</guid>\n";
	print FOUT "<pubDate>$date</pubDate>\n";
	print FOUT "<enclosure url=\"", htmlentities($file{url}), "\" length=\"1\" type=\"application/octet-stream\" />\n";
	print FOUT "<description>";
	print FOUT htmlentities("$item{title}<br/>From: $source{name}<br/>");
	print FOUT htmlentities("Tags: $tags<br/>\n");
	print FOUT htmlentities("$item{desc}");
	print FOUT "</description>\n";
	print FOUT "</item>\n";
    }

    $createdxml[$#createdxml+1] = "multimedia.xml";
    open(FOUT, ">multimedia.xml");

    my @s = stat("multimedia-input.xml");
    my $date = POSIX::strftime("%a, %d %b %Y %H:%M:%S %Z", localtime($s[9]));

    print FOUT <<EOF;
<rss version="2.0">
<channel>
<title>FreeBSD Multimedia Resources List</title>
<description>FreeBSD Multimedia Resources</description>
<link>http://www.FreeBSD.org/docs/multimedia.html</link>
<lastBuildDate>$date</lastBuildDate>
EOF

    foreach my $order (@date_order) {
	my %item = %{$items[$order]};
	my %source = %{$sources{$item{source}}};

	if (defined $item{overview}) {
	    printxml_multiple(\%item, \%source);
	} else {
	    printxml_single(\%item, \%source, $item{files}{0});
	}
    }

    print FOUT <<EOF;
</channel>
</rss>
EOF
    close(FOUT);
}


#
# Created files
#
{
    open(FOUT, ">multimedia.html.created");
    foreach my $f (@createdhtml) {
	print FOUT "$f\n";
    }
    close(FOUT);

    open(FOUT, ">multimedia.sgml.created");
    foreach my $f (@createdsgml) {
	print FOUT "$f\n";
    }
    close(FOUT);
}
