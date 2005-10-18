<!-- $FreeBSD: www/en/ports/ports.inc,v 1.67 2003/08/03 12:08:38 kuriyama Exp $ -->
<p>The FreeBSD Ports and Packages Collection offers a simple way for
users and administrators to install applications.  The ports
collection has been <a
href="growth/status.png">growing at a
tremendous rate</a>.
</p>

<p>The Ports Collection supports the latest release on the
FreeBSD-CURRENT and FreeBSD-STABLE branches.  Older releases are not
supported and may or may not work correctly with an up-to-date ports
collection.  Over time, changes to the ports collection may rely on
features that are not present in older releases.  Wherever convenient,
we try not to gratuitously break support for recent releases, but it
is sometimes unavoidable.  When this occurs, patches contributed by
the user community to maintain support for older releases will usually
be committed.
</p>

<p>Each ``port'' listed here
contains any patches necessary to make the original application source
code compile and run on FreeBSD.  Installing an application is as
simple as downloading the port, unpacking it and typing
<a href="http://www.freebsd.org/cgi/man.cgi?query=make"><tt>make</tt></a>
in the port directory.  However, the most convenient (and common) method
is to download the framework for the entire list of ports by
installing the <a href="ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/ports/ports.tar.gz">
entire ports hierarchy</a> at FreeBSD installation time,
and then have thousands of applications right at your
fingertips.
</p>

<p>
Each port's <tt>Makefile</tt> automatically fetches the
application source code, either from a local disk, CDROM or via
<a href="http://www.freebsd.org/cgi/man.cgi?query=ftp"><tt>ftp</tt></a>,
unpacks it on your system, applies the patches, and compiles.  If
all went well, a simple <tt>make install</tt> will install the
application and register it with the package system.</p>

<p>For most ports, a precompiled <tt>package</tt> also exists, saving
the user the work of having to compile anything at all.  Each port
contains a link to its corresponding package and you may either simply
download that file and then run the
<a href="http://www.freebsd.org/cgi/man.cgi?query=pkg_add"><tt>pkg_add</tt></a>
command
on it or you can simply grab the link location and hand it straight
to <tt>pkg_add</tt> since it's capable of accepting FTP URLs as
well as filenames.</p>

<p>For more information, see <a
href="../doc/en_US.ISO8859-1/books/handbook/ports.html">Installing Applications: Packages and Ports</a>, a
section of the <a href="../doc/en_US.ISO8859-1/books/handbook/index.html">FreeBSD Handbook</a>.  For
information about creating new ports, see the <a
href="../doc/en_US.ISO8859-1/books/porters-handbook/index.html">Porter's Handbook</a>.</p> 
<hr>

<h3>Keeping up-to-date</h3>

<p>
The ports listed on these web pages are continually being updated.
It is strongly recommended that you refresh the entire collection
together, as many ports depend on other parts of the tree, even
where that might seem counterintuitive (e.g. <tt>japanese/</tt>.)
</p>

<p>For more information about new, changed or removed ports/packages,
or if you wish to search for a specific application to see if it's
available as a port/package, you may browse the
<a href="http://www.FreeBSD.org/cgi/ports.cgi">FreeBSD Ports Changes</a>
on this site; alternatively, you may wish to visit
<a href="http://www.FreshPorts.org">FreshPorts.org</a>
and either browse the site or subscribe to the lists hosted there.</p>

<FORM METHOD="GET" ACTION="http://www.FreeBSD.org/cgi/ports.cgi">
Search for:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">All</OPTION>
<OPTION VALUE="name">Package Name</OPTION>
<OPTION VALUE="text">Description</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="Submit">
</FORM>

