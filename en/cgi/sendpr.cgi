#!/usr/bin/perl
#
#	$NetBSD: sendpr.cgi,v 1.2 1996/06/14 19:53:07 thorpej Exp $
#
# Generate a form to accept a problem report
#
# gndb specifies the database.  The file name would be gndb.def.
#
# Copyright (c) 1996 Free Range Media
#
#  Copying and distribution permitted under the conditions of the
#  GNU General Public License Version 2.  
#     (http://www.gnu.ai.mit.edu/copyleft/gpl.html)
#

require "html.pl";

&www_content ("text","html");
&cgi_form_in();

$gndb = $cgi_data{"gndb"};
$gndb = "gnats" if (!$gndb);

if (-e "$gndb.def")
  {
    require "$gndb.def";
  }
else
  {
    &html_title ("Problem Report Error");
    &html_body();
    print "There is an error in the configuration of the problem\n",
	  "report form genator.  Please back up one page and report\n",
	  "the problem to the owner of that page.";
    &html_end();
    exit(1);
  }

#
# Some defaults.
#
if (!$gnsprcategory) { $gnsprcategory = "Category"; }

#
#  Generate the problem report form.
#
&html_title ($gnsptitle);
&html_body ($gnspbody);
#read and print $gnspfirst file
if ($gnspfirst && -e $gnspfirst)
  { print  `cat $gnspfirst` };
&html_form ("dosendpr.cgi");
&html_input ("hidden", "gndb", $gndb);
&html_input ("hidden", "submitterid", $gnsubmitter);
&html_input ("hidden", "confidential", "no");
print "<b>Your Electronic Mail Address</b>: <br>";
&html_input ("text", "email", "", "40");
print "<br><b>Your Name</b>: <br>";
&html_input ("text", "originator", "", "40");
print "<br><b>Your Organization or Company</b>: <br>";
&html_input ("text", "organization", "", "40");
print "<br><b>One line summary of the problem: <br>";
&html_input ("text", "synopsis", "", $gnsptacols);
if (@gncategory == 1) {
    &html_input ("hidden", "category", $gncategory[0]);
} else {
    print "<br><b>$gnsprcategory</b>: ";
    &html_select ("category", @gncategory);
}
print "<br><b>Severity</b>: ";
&html_select ("severity", "non-critical", "serious", "critical");
print "<br><b>Priority</b>: ";
&html_select ("priority", "low", "medium", "high");
print "<br>Class: ";
&html_select ("class", "sw-bug", "doc-bug", "change-request", "support");
if ($gnspaskrel) {
    print "<br><b>$gnspaskrel</b>: <br>";
    &html_input ("text", "release", "", "40");
} else {
    &html_input ("hidden", "release", $gnrelease);
}
if ($gnspaskenv) {
    print "<br><b>$gnspaskenv</b>: ";
    &html_textarea ("environment", $gnsptarows/2, $gnsptacols);
} else {
    &html_input ("hidden", "environment",
	     "$ENV{'REMOTE_HOST'}:$ENV{'HTTP_FROM'}:$ENV{'HTTP_USER_AGENT'}");
}

print "<br><b>Full Description</b>: <br>";
&html_textarea ("description", $gnsptarows, $gnsptacols, $gnspdescription);
print "<br><b>How to repeat the problem</b>: <br>";
&html_textarea ("howtorepeat", $gnsptarows, $gnsptacols);
print "<br><b>Fix to the problem if known</b>: <br>";
&html_textarea ("fix", $gnsptarows, $gnsptacols);
print "<br>";
&html_input ("submit", "", $gnspsubmit);
&html_input ("reset", "", $gnspreset);
&html_endform();
#read and print file $gnsplast
if ($gnsplast && -e $gnsplast)
  { print `cat $gnsplast` };
&html_end();
