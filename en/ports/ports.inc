<!-- $Id: ports.inc,v 1.23 1998-11-11 09:54:08 asami Exp $ -->
<p>The FreeBSD Ports and Packages Collection offers a simple way for
users and administrators to install applications.  Each ``port'' listed here
contains any patches necessary to make the original application source
code compile and run on FreeBSD.  Installing an application is as
simple as downloading the port, unpacking it and typing <tt>make</tt>
in the port directory.  The <tt>Makefile</tt> automatically fetches the
application source code, either from a local disk, CDROM or via ftp,
unpacks it on your system, applies the patches, and compiles.  If
all goes well, simply type <tt>make install</tt> to install the
application and register it with the package system.</p>

<p>For most ports, a precompiled <tt>package</tt> also exists, saving
the user the work of having to compile anything at all.  Each port
contains a link to its corresponding package and you may either simply
download that file and then run the <strong>pkg_add</strong> command
on it or you can simply grab the link location and hand it straight
to <strong>pkg_add</strong> since it's capable of accepting FTP URLs as
well as filenames.</p>

<p>For more information about using ports, see <a
href="../handbook/ports.html">The ports collection</a>.  For
information about creating new ports, see <a
href="../handbook/porting.html">Porting applications</a>.  Both are
part of the <a href="../handbook">FreeBSD Handbook</a>.</p>

<p>If you are a 2.2.1-release user, please install the <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-stable/Latest/221upgrade.tgz">2.2.1
to 2.2-stable upgrade kit</a>; if you are
a 2.2.2-release user, please install the <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-stable/Latest/222upgrade.tgz">2.2.2
to 2.2-stable upgrade kit</a>; if you are a 2.2.5-release user,
please install the <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-stable/Latest/225upgrade.tgz">2.2.5
to 2.2-stable upgrade kit</a>; if you are a 2.2.6, 2.2.7 or 3.0-release user,
please install the <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-stable/Latest/227upgrade.tgz">2.2.7
to 2.2-stable upgrade kit</a>.  (These
are FreeBSD packages; please use pkg_add to install them.)  That
should enable you to use all the ports listed here.  Note that it will
only change just enough files to enable ports/packages to be used; for
a full upgrade to 2.2-stable, please refer to the <a
href="../handbook/synching.html">synchronizing your source tree</a>
section of the handbook.  A full upgrade is recommended, especially if
you are still using 2.2.1-release or 2.2.2-release.</p>

<p>Many of the ports require the X Window System to compile and run.
We compile and test our ports on <a
href="http://www.xfree86.org/">XFree86</a>. Their current release is
3.3.2.  Some ports may not work with older releases.</p>

<p>For more information about new, changed or removed ports/packages,
or if you wish to search for a specific application to see if it's
available as a port/package, please see the 
<a href="http://www.freebsd.org/cgi/ports.cgi">FreeBSD Ports Changes</a>
page.</p>

<FORM METHOD="GET" ACTION="http://www.freebsd.org/cgi/ports.cgi">
Search for:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">All</OPTION>
<OPTION VALUE="name">Package Name</OPTION>
<OPTION VALUE="text">Description</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="Submit">
</FORM>

