<p>The FreeBSD Ports Collection offers a simple way for users and
administrators to install applications.  Each ``port'' listed here
contains any patches necessary to make the original application source
code compile and run on FreeBSD.  Installing an application is as
simple as downloading the port, unpacking it and typing <tt>make</tt>
in the port directory.  The <tt>Makefile</tt> automatically fetches the
application source code, either from a local disk or via ftp,
unpacks it on your system, applies the patches, and compiles.  If
all goes well, simply type <tt>make install</tt> to install the
application.</p>

<p>For more information about using ports, see <a
href="../handbook/ports.html">The ports collection</a>.  For
information about creating new ports, see <a
href="../handbook/porting.html">Porting applications</a>.  Both are
part of the <a href="../handbook">FreeBSD Handbook</a>.</p>

<p>For more information about new ports, changed ports,
removed ports, or searching for an application see the 
<a href="http://www.de.freebsd.org/de/cgi/ports.cgi">
FreeBSD Ports Changes</a> script.</p>

<p>If you are a 2.2.1-release user, please install the <a
href="ftp://ftp.freebsd.org/pub/FreeBSD/packages-2.2/22upgrade-97.04.18.tgz">2.2.1
to 2.2-stable upgrade kit</a> (last changed: April 18, 1997).  This
will enable you to use all the ports listed here.  Note that it will
only change just enough files to enable ports/packages to be used; for
a full upgrade to 2.2-stable, please refer to the <a
href="../handbook/synching.html">synchronizing your source tree</a>
section of the handbook.
