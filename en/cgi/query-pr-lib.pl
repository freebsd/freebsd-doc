#!/usr/bin/perl -Tw

sub get_categories {
    @categories = ();

    open(Q, 'query-pr.web --list-categories 2>/dev/null |') ||
	die "Cannot get categories\n";

    while(<Q>) {
	chop;
	local ($cat, $desc, $responsible, $notify) = split(/:/);
	push(@categories, $cat);
	$catdesc{$cat} = $desc;
    }
}

sub get_states {
    @states = ();

    open(Q, 'query-pr.web --list-states 2>/dev/null |') ||
	die "Cannot get states\n";

    while(<Q>) {
	chop;
	local ($state, $type, $desc) = split(/:/);
	push(@states, $state);
	$statedesc{$state} = $desc;
    }
}

sub get_classes {
    @classes = ();

    open(Q, 'query-pr.web --list-classes 2>/dev/null |') ||
	die "Cannot get classes\n";

    while(<Q>) {
	chop;
	local ($class, $type, $desc) = split(/:/);
	push(@classes, $class);
	$classdesc{$class} = $desc;
    }
}

sub displayform {
print qq`
<p>To query the GNATS Database for specific PR number, please fill in
this form:</p>
<form action='./query-pr.cgi' method='get'>
<table cellspacing='0' cellpadding='3' class='headtable'>
<tr><td width='130'><b>PR number:</b></td><td><input type='text'
  name='pr' maxlength='30' /></td></tr>
<tr><td width='130'><b>Category:</b></td><td><input type='text'
  name='cat' maxlength='30' /> (optional)</td></tr>
<tr><td colspan='2'><input type='submit' value='Submit' />
<input type='reset' value='Reset Form' /></td></tr>
</table>
</form>

<p>Alternatively, it is possible to select items you wish to search for.
Multiple items are AND'ed together.<br />
To generate current list of all open PRs in GNATS database, just press
the "Query PRs" button.
</p>
<form method='get' action='./query-pr-summary.cgi'>

<table cellspacing="0" cellpadding="3" class="headtable">
<tr>
<td><b>Category</b>:</td>
<td><select name='category'>
<option selected='selected' value=''>Any</option>`;

&get_categories;
foreach (sort @categories) {
    #print "<option value='$_'>$_ ($catdesc{$_})</option>\n";
    print "<option>$_</option>\n";
}

print qq`
</select></td>
<td><b>Severity</b>:</td>
<td><select name='severity'>
<option selected='selected' value=''>Any</option>
<option>non-critical</option>
<option>serious</option>
<option>critical</option>
</select></td>
</tr><tr>
<td><b>Priority</b>:</td>
<td><select name='priority'>
<option selected='selected' value=''>Any</option>
<option>low</option>
<option>medium</option>
<option>high</option>
</select></td>
<td><b>Class</b>:</td>
<td><select name='class'>
<option selected='selected' value=''>Any</option>
`;

&get_classes;
foreach (@classes) {
	#print "<option value='$_'>$_ ($classdesc{$_})</option>\n";
	print "<option>$_</option>\n";
}

print qq`</select></td>
</tr><tr>
<td><b>State</b>:</td>
<td><select name='state'>
<option selected='selected' value=''>Any</option>
`;

&get_states;
foreach (@states) {
	($us = $_) =~ s/^./\U$&/;
	print "<option value='$_'>";
	#print "$us ($statedesc{$_})</option>\n";
	print "$us</option>\n";
}

print qq`</select></td>
<td><b>Sort by</b>:</td>
<td><select name='sort'>
<option value='none'>No Sort</option>
<option value='lastmod'>Last-Modified</option>
<option value='category'>Category</option>
<option value='responsible'>Responsible Party</option>
</select></td>
</tr><tr>
<!-- We don't use submitter Submitter: -->
<td><b>Text in single-line fields</b>:</td>
<td><input type='text' name='text' /></td>
<td><b>Responsible</b>:</td>
<td><input type='text' name='responsible' /></td>
</tr><tr>
<td><b>Text in multi-line fields</b>:</td>
<td><input type='text' name='multitext' /></td>
<td><b>Originator</b>:</td>
<td><input type='text' name='originator' /></td>
</tr><tr>
<td><b>Closed reports too</b>:</td>
<td><input name='closedtoo' value='on' type='checkbox' /></td>
<td><b>Release</b>:</td>
<td><select name='release'>
<option selected='selected' value=''>Any</option>
<option value='^FreeBSD [2345]'>Pre-6.X</option>
<option value='^FreeBSD 6'>6.X only</option>
<option value='^FreeBSD 5'>5.X only</option>
<option value='^FreeBSD 4'>4.X only</option>
<option value='^FreeBSD 3'>3.X only</option>
<option value='^FreeBSD 2'>2.X only</option>
</select></td>
</tr>
<tr><td colspan="2"><input type='submit' value='Query PRs' />
<input type='reset' value='Reset Form' /></td></tr>
</table>
</form>
`;
}

1;
