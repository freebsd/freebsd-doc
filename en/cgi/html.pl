#	$NetBSD: html.pl,v 1.2 1996/06/14 19:52:38 thorpej Exp $
#
# perl routines to help generate html from cgi scripts in perl.
#
# written by Philip A. Nelson, 1995 and 1996.
#
#  Copyright (c) 1995, 1996 Philip A. Nelson.
#
#  Last modified: May 13, 1996.
#
#  Copying and distribution permitted under the conditions of the
#  GNU General Public License Version 2.  
#     (http://www.gnu.ai.mit.edu/copyleft/gpl.html)
#
# $FreeBSD$

#
# typical use is &www_content ("text","html");
#	Should be the first output from a cgi script.
#
sub www_content {
  print "Content-type: $_[0]/$_[1]\n\n";
}

#
# &html_title ( title, other_head_html )
#	Starts the html with a head and title.
#
sub html_title {
  print "<html>\n<head>\n<title>$_[0]</title>\n$_[1]\n</head>\n";
}

#
# &html_body (Body_tag_attributes);
#
sub html_body {
  print "<body $_[0]>\n";
}

#
# Last call to end a complete html page.
#	&html_end();
#
sub html_end {
  print "</body>\n</html>\n";
}

#
# &www_href (URL, link text, anchor_name)
#    link text and anchor name are optional.
#    If no link text, no </a> is generated.
#
sub html_href {
  print "<a href=\"$_[0]\"";
  if ($_[2]) { print "name=\"$_[2]\""; }
  if ($_[1]) { print $_[1], "</a>"; }
}

#
#  &cgi_form_in();
#
#  Form support:
#	Defines:
#	    $cgi_data{$key} the data indexed by the key.
#		keys repeated twice gets data collected in
#		$cgi_data{$key} separated by "|"s.
#
#	    @keys (sequential list of keys)
#	    @vals (sequential list of values)
#	    $cgi_method
#
sub cgi_form_in {
  local ($data);
  $cgi_method = $ENV{'REQUEST_METHOD'};
  if ($cgi_method eq 'GET') {
    $data = $ENV{'QUERY_STRING'};
  } else {
    read(STDIN,$data,$ENV{'CONTENT_LENGTH'});
  }
  @lines = split (/&/, $data);
  $nkeys = 0;
  foreach $line (@lines) {
    ($key,$val) = split (/=/, $line);
    $val =~ s/\+/ /g;
    $val =~ s/%([0-9A-Fa-f][0-9A-Fa-f])/pack("C",hex($1))/eg ;
    if ($cgi_data{$key}) {
	$cgi_data{$key} = $cgi_data{$key}."|".$val;
    } else {
	$cgi_data{$key} = $val;
    }
    push (@keys, "$key");
    push (@vals, "$val");
    $nkeys += 1;
  }
}

#
# Form creation routines
#

#
# &html_form (action)  - form with post method
#
sub html_form {
  print "<form action=\"$_[0]\" method=POST>\n";
}

#
# &html_getform (action)  - form with get method
#
sub html_getform {
  print "<form action=\"$_[0]\" method=POST>\n";
}

#
# &html_endform();
#
sub html_endform {
  print "</form>\n";
}

#
# &html_input (type, name, value, size, maxlength, checked)
#
sub html_input {
  local ($type, $name, $value, $size, $maxlength, $checked) = @_;
  print "<input type=\"$type\" ";
  if ($name)      { print "name=\"$name\" "; }
  if ($value)     { print "value=\"$value\" "; }
  if ($size)      { print "size=\"$size\" "; }
  if ($maxlength) { print "maxlength=\"$maxlength\" "; }
  if ($checked)   { print "checked "; }
  print ">\n";
}

#
# &html_radio (name, value_list)
#
sub html_radio {
  local ($name, @values) = @_;
  foreach $val (@values) {
    &html_input ("radio", $name, $val);
  }
}

#
# &html_checkbox (name, values)
#    checked values include a : which is removed.
#
sub html_checkbox {
  local ($name, @values) = @_;
  foreach $val (@values) {
    $val1 = $val;
    $val1 =~ s/://;
    if ($val eq $val1) 
      { &html_input ("checkbox", $name, $val); }
    else
      { &html_input ("checkbox", $name, $val1,"" ,"" ,"checked"); }
    print $val1;
  }
}

#
# &htlm_select (name, options ...)
#
#   options including : are selected and the : is removed.
#
sub html_select {
  local ($name, @options) = @_;
  print "<select name=\"$name\">\n";
  foreach $opt (@options) {
    $opt1 = $opt;
    $opt1 =~ s/://;
    if ($opt eq $opt1) 
      { print "<option> $opt1\n"; }
    else
      { print "<option SELECTED> $opt1\n"; }
  }
  print "</select>\n";
}

#
# &htlm_selectmult (name, options ...)
#
#    allow multiple selections
#
sub html_selectmult {
  local ($name, @options) = @_;
  print "<select name=\"$name\" multiple>\n";
  foreach $opt (@options) {
    $opt1 = $opt;
    $opt1 =~ s/://;
    if ($opt eq $opt1) 
      { print "<option> $opt1\n"; }
    else
      { print "<option SELECTED> $opt1\n"; }
  }
  print "</select>\n";
}

#
#  &html_textarea (name, rows, cols, value);
#
sub html_textarea {
  local ($name, $rows, $cols, $value) = @_;
  print "<textarea name=\"$name\" rows=\"$rows\" cols=\"$cols\">\n";
  print "$value\n";
  print "</textarea>"; 
}

# return true!
1;
