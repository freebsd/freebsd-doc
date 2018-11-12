<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "FreeBSD/ia64 Project">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD$'"/>

  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="iso-8859-1" method="html"/>

  <xsl:template match="/">
    <html>
      &header1;
      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    &header2;

	    <div id="CONTENT">
	      <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;

		<img align="right" alt="Montecito die" src="montecito-die.png"/>

		<p>Search the FreeBSD/ia64 PR database:</p>

	<form action="http://www.FreeBSD.org/cgi/query-pr-summary.cgi"
	      method="get">
	    <input type="hidden" name="category" value="ia64"/>
	    <input type="hidden" name="sort" value="none"/>
	    <input type="text" name="text"/>
	    <input type="submit" value="Go"/>
		</form>

	<h3>
	  What needs to be done
	</h3>
	<p>
	  This page tries to be the starting point for people trying to find
	  anything that can be done. The order of the items on this page are
	  not strictly an indication of priority, but it is a good indication.
	  There are in all likelihood tasks that are not mentioned here, but
	  that should be done nonetheless. A typical example is the maintenance
	  of the ia64 web pages... unfortunately.
	</p>

	<h4>
	  Becoming a tier 1 platform
	</h4>
	<p>
	  With two releases as a tier 2 platform, it is time to work towards
	  becoming a tier 1 platform. This involves tasks as varied as:
	</p>
	<ul>
	  <li>
	    Improve the installation process to take into account that
	    there is already a GPT with an EFI partition, including other
	    operating systems. The ability to add a FreeBSD entry to the
	    EFI boot menu is also a nice thing.
	  </li>
	  <li>
	    Port the GNU debugger. It is sorely missed on a development
	    machine and required on tier 1 platforms.
	  </li>
	  <li>
	    Port the X server (ports/x11/XFree86-4-Server). Not really
	    required for tier 1 status, but one cannot truly do without
	    if one wants to use ia64 as a desktop machine.
	  </li>
	</ul>

	<h4>
	  Ports and packages
	</h4>
	<p>
	  A very important task for the success of FreeBSD on ia64 is making
	  sure that users have something to run besides ls(1). Our huge ports
	  collection has been targeting ia32 for the most part, so it is not
	  surprising that there are a lot of ports that do not build or do not
	  work on ia64. Look
	  <a href="http://pointyhat.FreeBSD.org/errorlogs/ia64-8-latest/">
	    here
	  </a>
	  for the most up-to-date list of ports that fail to build for some
	  reason or another. Note that if there are ports depending on one or
	  more ports that fail, those are not built and are not counted. A good
	  way to help out here is to work on those ports that have a lot of
	  ports depending on it (see the "Aff." column in the table).
	</p>

	<h4>
	  Sharpening the saw
	</h4>
	<p>
	  There are plenty functions (especially assembly routines) that
	  have been written to provide the missing functionality without any
	  consideration for speed and/or robustness. Reviewing those functions
	  and replacing them if necessary is a good task that can be done
	  concurrently and independently from other activity and does not
	  necessarily require huge amounts of knowledge and/or experience.
	</p>

	<h4>
	  Core development
	</h4>
	<p>
	  On top of the high-level things that do not work or do not exist,
	  there is also some rather involved rewriting to be done at the
	  foundation and can potentially affect all other platforms as well.
	  This includes:
	</p>
	<ul>
	  <li>
	    Improve UP and SMP stability by revamping the PMAP module.
	    The low-level handling of VM translations needs to be improved.
	    This involves both correctness as well as performance.
	  </li>
	  <li>
	    Basic device drivers such as sio(4) and syscons(4) do not
	    work on ia64 machines that do not have support for legacy
	    devices. This is a rather big issue, because it affects all
	    platforms and may involve rewriting (big) parts of certain
	    subsystems. Clearly a task that needs wholesale support and
	    coordination.
	  </li>
	  <li>
	    Better handling of sparse (physical) memory configurations
	    by not creating VM tables that span the whole address space,
	    but rather cover the memory "chunks" that are present. We are
	    currently forced to ignore memory because of this.
	  </li>
	</ul>

	      </div> <!-- CONTENTWRAP -->

	      <br class="clearboth" />
	    </div> <!-- CONTENT -->
            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
	  </div> <!-- CONTAINER -->
	</div> <!-- CONTAINERWRAP -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
