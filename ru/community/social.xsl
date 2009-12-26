<?xml version="1.0" encoding="KOI8-R" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "Социальные сети FreeBSD">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD: www/ru/community/social.xsl,v 1.2 2009/12/22 04:52:59 bland Exp $

     Original revision: 1.2
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:output method="xml" encoding="&xml.encoding;"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:template match="events">
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

	      <p>&os; представлена в различных социальных сетях.</p>

	      <ul>

	        <li>Тысячи пользователей пометили около 30,000
	        уникальных веб страниц меткой '<a
	        href="http://del.icio.us/tag/freebsd">freebsd</a>'
	        на <a href="http://del.icio.us">del.icio.us</a>.</li>

		<li>Тысячи фотографий со встреч групп пользователей,
		конференций и хакатонов помечены меткой '<a
		href="http://flickr.com/search/?z=t&amp;ss=2&amp;w=all&amp;q=freebsd&amp;m=text">freebsd</a>'
		на <a href="http://www.flickr.com">flickr</a>.</li>

		<li>Сотни видеороликов с конференций,
		скринкастов и демонстраций, связанных с <a
		href="http://www.youtube.com/results?search_query=freebsd&amp;search_type=&amp;aq=f">FreeBSD</a>,
		на <a href="http://www.youtube.com">YouTube</a>. В частности, там же размещен канал <a href="http://www.youtube.com/bsdconferences">BSD Conferences</a>, содержащий около 1 часа записей презентаций, сделанных на технических конференциях FreeBSD.</li>

		<li><a
		href="http://www.facebook.com/home.php#/group.php?gid=2204657214">
		Группа пользователей FreeBSD</a> на <a
		href="http://www.facebook.com">Facebook</a> и <a href="http://www.linkedin.com/groups?gid=47628">группа FreeBSD</a> на <a href="http://www.linkedin.com">LinkedIn</a>.</li>

		<li>Вы можете следить за <a
		href="http://twitter.com/freebsdannounce">@freebsdannounce</a>,
		<a
		href="http://twitter.com/freebsdblogs">@freebsdblogs</a>,
		<a href="http://twitter.com/freebsd">@freebsd</a> или
		<a href="http://twitter.com/bsdevents">@bsdevents</a>
		на <a href="http://twitter.com">Twitter</a>.</li>

	      </ul>

	      <h3>Активность в блогах</h3>

	      <p>Сообщения, относящиеся к <a
href="http://technorati.com/search/freebsd?sub=chartlet&amp;language=n&amp;authority=n">FreeBSD</a>, за последние 90 дней.<br /><a
href="http://technorati.com/search/freebsd?sub=chartlet&amp;language=n&amp;authority=n"><img
src="http://technorati.com/chartimg/freebsd?totalHits=24190&amp;size=s&amp;days=90"
style="border:0" alt="Technorati Chart" /></a>
              </p>

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
