<?xml version="1.0" encoding="koi8-r" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "Социальные сети FreeBSD">
]>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$

     Original revision: 1.6
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.sidewrap">
    &nav.community;
  </xsl:template>

  <xsl:template name="process.contentwrap">
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
  </xsl:template>
</xsl:stylesheet>
