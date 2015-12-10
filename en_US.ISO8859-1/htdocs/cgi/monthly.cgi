#!/usr/bin/perl -w
# $FreeBSD$

require "./cgi-style.pl";

use CGI qw(:all);
use strict;

my $Submit = param("Submit");
my $debug  = param("debug") || "";

my $NumDevelopers = 3;
my $NumLinks      = 4;
my $NumSponsors   = 2;
my $NumTasks      = 5;

my @messages;

#
# Routine to format some xml nicely
#
sub xml
{
	my($Indent, $TagEtc, @Text) = @_;

	my($Tag, $Etc) = split(' ', $TagEtc, 2);

	my $Spaces = " " x ($Indent*2);
	if (!@Text)
	{
		# No text in the tag
		return ("$Spaces<$TagEtc />\n");
	}
	elsif (@Text == 1)
	{
		# Bottom level tag - output on one line
		return ("$Spaces<$TagEtc>@Text</$Tag>\n");
	}
	else
	{
		# This is not a bottom level tag - output a new line after
		# starting tag
		return ("$Spaces<$TagEtc>\n",
				@Text,
				"$Spaces</$Tag>\n");
	}
}

#
# As above to format indented text but no tag
#
sub xmltext
{
	my($Indent, @Text) = @_;

	my $Spaces = " " x ($Indent*2);

	return map { "$Spaces$_\n" } @Text;
}

if ($Submit)
{
	my $errors = 0;

	my @hidden;

	my $Project = param("Project") || "";
	my $Category = param("Category") || "misc";
	push(@hidden, hidden("Project"));

	my @contacts;
	foreach my $Num (1..$NumDevelopers)
	{
		my $fname = param("FirstName$Num") || "";
		my $lname = param("LastName$Num")  || "";
		my $email = param("Email$Num")     || "";

		push(@hidden, hidden("FirstName$Num"));
		push(@hidden, hidden("LastName$Num"));
		push(@hidden, hidden("Email$Num"));

		next unless $fname || $lname || $email;

		my @name;
		push(@name, xml(4, 'given',  $fname)) if $fname;
		push(@name, xml(4, 'common', $lname)) if $lname;

		my @person;
		push(@person, xml(3, 'name',  "", @name))  if @name;
		push(@person, xml(3, 'email', $email)) if $email;

		push(@contacts, xml(2, 'person', "", @person));
	}

	if (!@contacts)
	{
		++$errors;
		push(@messages, b("Please specify at least one contact"));
	}

	my @links;
	foreach my $Num (1..$NumLinks)
	{
		my $url  = param("Url$Num")  || "";
		my $desc = param("Desc$Num") || "";

		push(@hidden, hidden("Url$Num"));
		push(@hidden, hidden("Desc$Num"));

		next unless $url;
		my @link;
		if ($desc)
		{
			push(@links, xml(2, "url href=\"$url\"", $desc));
		}
		else
		{
			push(@links, xml(2, "url href=\"$url\""));
		}
	}

	my @sponsors;
	foreach my $Num (1..$NumSponsors)
	{
		my $sponsor = param("Sponsor$Num")  || "";
		push(@hidden, hidden("Sponsor$Num"));

		next unless $sponsor;
		push(@sponsors, xml(1, "sponsor", "", xmltext(2, $sponsor)));
	}

	if (@sponsors)
	{
		push(@sponsors, "\n");
	}

	my @tasks;
	foreach my $Num (1..$NumTasks)
	{
		my $desc = param("Task$Num") || "";
		$desc =~ s/\r//g;
		my @desc = split("\n", $desc);

		push(@hidden, hidden("Task$Num"));

		next unless $desc;
                push(@tasks, xml(2, "task", "",xmltext(3, @desc)));
	}

	my $info = param("SubmittedInfo") || "";
	push(@hidden, hidden("SubmittedInfo"));

	$info =~ s/\r//g;
	my @info = split("\n", $info);

	my $title = "FreeBSD project submission output";

	my @contents = xml(0, "project cat=\'$Category\'",
	    xml(1, "title", $Project),
	    "\n",
	    xml(1, "contact", "", @contacts),
	    "\n",
            xml(1, "links", "", @links),
            "\n",
            xml(1, "body",
                xml(2, "p", "", xmltext(3, @info))),
            "\n",
            @sponsors,
            xml(1, "help", "", @tasks),
        );
	my $contents = join('', @contents);

	$contents = "<!-- Mail as an attachment to: monthly\@freebsd.org -->\n$contents";

	if (!$errors)
	{
                print "Content-Type: text/plain\n\n";
                print $contents;
                exit;
	}
}

my @DeveloperTable;
foreach my $Num (1..$NumDevelopers)
{
	push(@DeveloperTable,
		 TR(td(textfield(-name => "FirstName$Num", -size => 20)),
			td(textfield(-name => "LastName$Num",  -size => 20)),
			td(textfield(-name => "Email$Num",     -size => 32))));
}

my @LinksTable;
foreach my $Num (1..$NumLinks)
{
	push(@LinksTable,
		 TR(td(textfield(-name => "Url$Num",      -size => 55)),
			td(textfield(-name => "Desc$Num",     -size => 20))));
}

my @SponsorTable;
foreach my $Num (1..$NumSponsors)
{
	push(@SponsorTable,
		 TR(td(textarea(-name => "Sponsor$Num", -rows => 1, -cols => 60))));
}

my @TaskTable;
foreach my $Num (1..$NumTasks)
{
	push(@TaskTable,
		 TR(td(textarea(-name => "Task$Num", -rows => 3, -cols => 60))));
}

print
  (html_header("Submitting a FreeBSD Project Status Report"),
   hr,
   join("<BR>\n", @messages, ""),
   p("To submit status information about a FreeBSD project, fill out the",
       " following:"),
   start_form(),

   h3("Project:"),
   textfield(-name => "Project", -size => "32"),

   h3("Category:"),
   popup_menu(-name => "Category",
       -values => ['proj', 'docs', 'kern', 'bin', 'arch', 'ports', 'vendor',
        'misc', 'soc', 'team'], -default => 'proj'),

   h3("Developers:"),
   blockquote(table({"BORDER" => 0,
					 "COLS"   => 3,
					 "NOSAVE" => 1},
					TR(td("First Name"),
					   td("Family Name"),
					   td("Email address")),
					@DeveloperTable)),

   h3("Links:"),
   blockquote(table({"BORDER" => 0,
					 "COLS"   => 2,
					 "NOSAVE" => 1},
					TR(td("Url"),
					   td("Description")),
					@LinksTable)),

   h3("Present status:"),
   p("You can use &quot;simple&quot; HTML tags (e.g. &lt;p&gt;, ",
       "&lt;em&gt;, &lt;strong&gt; and &lt;a href=... &gt;) to format."),
   blockquote(textarea(-name => "SubmittedInfo",
					   -rows => 7,
					   -cols => 60)),

   h3("Sponsors (optional):"),
   blockquote(table({"BORDER" => 0,
					 "COLS"   => 1,
					 "NOSAVE" => 1},
					TR(td("Name")),
					@SponsorTable)),

   h3("Open tasks (optional):"),
   blockquote(table({"BORDER" => 0,
					 "COLS"   => 5,
					 "NOSAVE" => 1},
					TR(td("Description")),
					@TaskTable)),


   submit(-name => "Submit", -label => "Download XML"),
   reset(-value => "Reset"),
   br,
   end_form(),
   html_footer());

__END__
