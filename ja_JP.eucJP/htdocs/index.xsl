<?xml version="1.0" encoding="EUC-JP" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- $FreeBSD$ -->
<!-- Original revision: 1.178 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="advisories.xml" select="'none'"/>
  <xsl:param name="notices.xml" select="'none'"/>
  <xsl:param name="mirrors.xml" select="'none'"/>
  <xsl:param name="news.press.xml-master" select="'none'"/>
  <xsl:param name="news.press.xml" select="'none'"/>
  <xsl:param name="news.project.xml-master" select="'none'"/>
  <xsl:param name="news.project.xml" select="'none'"/>
  <xsl:param name="events.xml-master" select="'none'"/>
  <xsl:param name="events.xml" select="'none'"/>
  <xsl:param name="html.header.script.google" select="'IGNORE'"/>

  <xsl:output type="html" encoding="EUC-JP"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>&title;</title>
	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Ports,
	      Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	      CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
<!--
	FOR TRANSLATORS:

	Do not translate the "Normal Text" and "Large Text" attributes in the
	following two lines.  They are not literal texts but JavaScript
	parameters.  Changing them will result in rendering errors.
-->
	<link rel="stylesheet" media="screen" href="&enbase;/layout/css/fixed.css?20060509" type="text/css" title="Normal Text" />
	<link rel="alternate stylesheet" media="screen" href="&enbase;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
	<script type="text/javascript" src="&enbase;/layout/js/styleswitcher.js"></script>
	<xsl:if test="$html.header.script.google != 'IGNORE'">
	  <script type="text/javascript" src="&enbase;/layout/js/google.js"></script>
	</xsl:if>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Project News" href="&enbase;/news/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Security Advisories" href="&enbase;/security/rss.xml" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD GNOME Project News" href="&enbase;/gnome/rss.xml" />

	<!-- Formatted to be easy to spam harvest, please do not reformat. -->
	<xsl:comment>
        Spamtrap, do not email:
        &lt;a href="mailto:bruscar@freebsd.org"&gt;bruscar@freebsd.org&lt;/a&gt;
	</xsl:comment>
      </head>

      <body>

      <div id="CONTAINERWRAP">
	<div id="CONTAINER">
	  &header2;
	  <div id="CONTENT">

	    <div id="FRONTCONTAINER">
	      <div id="FRONTMAIN">
		<div id="FRONTFEATURECONTAINER">

		  <div id="FRONTFEATURELEFT">
		    <div id="FRONTFEATURECONTENT">
			<h1>
			  �١����� BSD UNIX<!-- &unix; -->(R)
			</h1>

			<p>FreeBSD<!-- &reg; -->(R) �ϡ��ǿ��Υ����С��ǥ����ȥåפ�����Ȥ߹���
			  <a href="&base;/platforms/">�ץ�åȥե�����</a>
			  �Ѥι���ǽ�ʥ��ڥ졼�ƥ��󥰥����ƥ�Ǥ���
			  FreeBSD �Υ����ɥ١����ϡ�
			  30 ǯ�ʾ�ˤ��ϤäƳ�ȯ�����ɡ���Ŭ����³�����Ƥ��ޤ���
			  <a href="&enbase;/doc/ja_JP.eucJP/articles/contributors/staff-committers.html"
			    >¿���ο͡������ä��볫ȯ�ԥ�����</a>
			  ����ȯ���ݼ�򤪤��ʤäƤ��ޤ���
			  FreeBSD �Ϲ��٤ʥͥåȥ�������Ǥʥ������ƥ���ǽ��
			  �������祯�饹�Υѥե����ޥ󥹤��󶡤���
			  �������絬�Ϥ� <a	
			  href = "&enbase;/doc/ja_JP.eucJP/books/handbook/nutshell.html#INTRODUCTION-NUTSHELL-USERS">�����֥�����</a> �䡢
			  ������ڤ��Ƥ����Ȥ߹��ߥͥåȥ�����
			  ���ȥ졼���ǥХ��������Ѥ���Ƥ��ޤ���
			</p>

			<div id="TXTFRONTFEATURELINK">
			  &#187;<a href="&base;/about.html" title="�ܤ����Ϥ�����">�ܤ����Ϥ�����</a>
			</div> <!-- TXTFRONTFEATURELINK -->
		    </div> <!-- FRONTFEATURECONTENT -->
		  </div> <!-- FRONTFEATURELEFT -->

		  <div id="FRONTFEATUREMIDDLE">
		      <div class="frontgetroundbox">
			<div class="frontgettop"><div>&#160;</div>&#160;</div>

			<div class="frontgetcontent">
			  <a href="&base;/where.html">FreeBSD �����ꤹ��</a>
			</div> <!-- frontgetcontent -->

			<div class="frontgetbot"><div>&#160;</div>&#160;</div>
		      </div> <!-- frontgetroundbox -->

			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
			  <h2><a href="&base;/releases/">�ǿ���꡼��</a></h2>
			  <ul id="FRONTRELEASESLIST">
			    <li>�ץ���������:&nbsp;<a
				href="&u.rel.announce;">&rel.current;</a>,&nbsp;<a href="&u.rel2.announce;">&rel2.current;</a></li>
			    <li>�쥬����: <a
				href="&u.rel3.announce;">&rel3.current;</a></li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
			    <li>����ͽ��: <a
				href="&base;/where.html#helptest">&betarel.current;-&betarel.vers;</a></li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
			    <li>����ͽ��: <a
				href="&base;/where.html#helptest">&betarel2.current;-&betarel2.vers;</a></li>
			    </xsl:if>
			  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		  </div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
		      <h2 class="blockhide">¾����ؤΥ��</h2>

		      <div id="LANGUAGENAV">
			<ul id="LANGUAGENAVLIST">
			  <li>
			    <a href="&enbase;/de/" title="�ɥ��ĸ�">de</a>
			  </li>
			  <li>
			    <a href="&enbase;/" title="�Ѹ�">en</a>
			  </li>
			  <li>
			    <a href="&enbase;/es/" title="���ڥ����">es</a>
			  </li>
			  <li>
			    <a href="&enbase;/fr/" title="�ե�󥹸�">fr</a>
			  </li>
			  <li>
			    <a href="&enbase;/hu/" title="�ϥ󥬥꡼��">hu</a>
			  </li>
			  <li>
			    <a href="&enbase;/it/" title="�����ꥢ��">it</a>
			  </li>
			  <li>
			    <a href="&enbase;/ja/" title="���ܸ�">ja</a>
			  </li>
			  <li>
			    <a href="&enbase;/nl/" title="��������">nl</a>
			  </li>
			  <li>
			    <a href="&enbase;/ru/" title="������">ru</a>
			  </li>
			  <li class="last-child">
			    <a href="&enbase;/zh_CN/" title="���� (���λ�)">zh_CN</a>
			  </li>
			</ul>
		      </div> <!-- LANGUAGENAV -->

		      <div id="MIRROR">
			<form action="&cgibase;/mirror.cgi" method="get">
			  <div>
			    <h2 class="blockhide"><label for="MIRRORSEL">�ߥ顼������</label></h2>
			    <select id="MIRRORSEL" name="goto">
			      <xsl:call-template name="html-index-mirrors-options-list">
				<xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
			      </xsl:call-template>
			    </select>
			  </div> <!-- unnamed -->
			  <input type="submit" value="��ư" />
			</form>
		      </div> <!-- MIRROR -->

		      <div id="FRONTSHORTCUTS">
			<div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
			  <h2>���硼�ȥ��å�</h2>
			  <ul id="FRONTSHORTCUTSLIST">
			    <li>
			      <a href="&base;/community/mailinglists.html" title="�᡼��󥰥ꥹ��">�᡼��󥰥ꥹ��</a>
			    </li>
			    <li>
			      <a href="&base;/support/bugreports.html" title="�Х������">�Х������</a>
			    </li>
			    <li>
			      <a href="&enbase;/doc/&url.doc.langcode;/books/faq/index.html" title="FAQ">FAQ</a>
			    </li>
			    <li>
			      <a href="&enbase;/doc/&url.doc.langcode;/books/handbook/index.html" title="�ϥ�ɥ֥å�">�ϥ�ɥ֥å�</a>
			    </li>
			    <li>
			      <a href="&base;/ports/index.html" title="Ports">Ports</a>
			    </li>
			  </ul>
			</div> <!-- FRONTSHORTCUTSCONTENT -->
		      </div> <!-- FRONTSHORTCUTS -->

		      <div class="frontnewroundbox">
			<div class="frontnewtop"><div>&#160;</div>&#160;</div>
			<div class="frontnewcontent">
			  <a href="&base;/projects/newbies.html">FreeBSD �����ƤȤ������ϡ�������ؤɤ���</a>
			</div> <!-- frontnewcontent -->
			<div class="frontnewbot"><div>&#160;</div>&#160;</div>
		      </div> <!-- frontnewroundbox -->
		    </div> <!-- FEATURERIGHT -->

		  </div> <!-- FRONTFEATURECONTAINER -->

		  <br class="clearboth" />

		  <div id="FRONTNEMSCONTAINER">
		    <div id="FRONTNEWS">
		      <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>�ǿ��˥塼��</h2>
			<div class="newseventswrap">
			  <xsl:call-template name="html-index-news-project-items">
			    <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
			    <xsl:with-param name="news.project.xml" select="$news.project.xml" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="first-child">
				<a href="&base;/news/newsflash.html" title="���٤ƤΥ˥塼��">���٤ƤΥ˥塼��</a>
			      </li>
			      <li class="last-child">
				<a href="&base;/news/rss.xml" title="�˥塼���� RSS �ե�����"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="News RSS Feed" /></a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- FRONTNEWSCONTENT -->
		    </div> <!-- FRONTNEWS -->

		    <div class="frontseparator"><b style="display: none">.</b></div>

		    <div id="FRONTEVENTS">
		      <div id="FRONTEVENTSCONTENT" class="txtnewsevent">
			<h2>���٥��ͽ��</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-events-items">
			    <xsl:with-param name="events.xml-master" select="$events.xml-master" />
			    <xsl:with-param name="events.xml" select="$events.xml" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="only-child">
				<a href="&base;/events/" title="���٤ƤΥ��٥��">���٤ƤΥ��٥��</a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- FRONTEVENTSCONTENT -->
		    </div> <!-- FRONTEVENTS -->

		    <div class="frontseparator"><b style="display: none">.</b></div>

		    <div id="FRONTMEDIA">
		      <div id="FRONTMEDIACONTENT" class="txtnewsevent">
			<h2>�˥塼������</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-news-press-items">
			    <xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
			    <xsl:with-param name="news.press.xml" select="$news.press.xml" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="only-child">
				<a href="&base;/news/press.html" title="���٤ƤΥ˥塼������">���٤ƤΥ˥塼������</a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		      </div> <!-- FRONTMEDIACONTENT -->
		    </div> <!-- FRONTMEDIA -->

		    <div class="frontseparator"><b style="display: none">.</b></div>

		    <div id="FRONTSECURITY">
		      <div id="FRONTSECURITYCONTENT" class="txtnewsevent">
			<h2>�������ƥ�����</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-advisories-items">
			    <xsl:with-param name="advisories.xml" select="$advisories.xml" />
			    <xsl:with-param name="type" select="'advisory'" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="first-child">
				<a href="&enbase;/security/advisories.html" title="���٤ƤΥ������ƥ�����">���٤�ɽ��</a>
			      </li>
			      <li class="last-child">
				<a href="&enbase;/security/rss.xml" title="�������ƥ������ RSS �ե�����"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Security Advisories RSS Feed" /></a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />

			<h2>Errata ����</h2>

			<div class="newseventswrap">
			  <xsl:call-template name="html-index-advisories-items">
			    <xsl:with-param name="advisories.xml" select="$notices.xml" />
			    <xsl:with-param name="type" select="'notice'" />
			  </xsl:call-template>

			  <div>
			    <ul class="newseventslist">
			      <li class="first-child">
				<a href="&enbase;/security/notices.html" title="���٤Ƥ� Errata ����">���٤�ɽ��</a>
			      </li>
			      <li class="last-child">
				<a href="&enbase;/security/errata.xml" title="Errata ����� RSS �ե�����"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="Errata Notices RSS Feed" /></a>
			      </li>
			    </ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->
		      </div> <!-- FRONTSECURITYCONTENT -->
		    </div> <!-- FRONTSECURITY -->

		    <br class="clearboth" />

		  </div> <!-- FRONTNEMSCONTAINER -->
		</div> <!-- FRONTMAIN -->
	      </div> <!-- FRONTCONTAINER -->
	    </div> <!-- CONTENT -->

      <div id="FOOTER">
	&copyright;

	The mark FreeBSD is a registered trademark of The FreeBSD
	Foundation and is used by The FreeBSD Project with the
	permission of <a
	  href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">The
	FreeBSD Foundation</a>.

	  </div> <!-- FOOTER -->
	</div> <!-- CONTAINER -->
      </div> <!-- CONTAINERWRAP -->
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

<!--
     Local Variables:
     mode: xml
     sgml-indent-data: t
     sgml-omittag: nil
     sgml-always-quote-attributes: t
     End:
-->
