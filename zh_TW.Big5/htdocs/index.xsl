<?xml version="1.0" encoding="Big5" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- The FreeBSD Traditional Chinese Documentation Project -->
<!-- Original revision: 1.158 -->
<!-- $FreeBSD$ -->

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

  <xsl:output type="html" encoding="&xml.encoding;"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>&title;</title>
	<meta name="description" content="The FreeBSD Project"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, �䴩, Ports,
	      �o�檩, ����, �n��, ��U, FAQ, �о�, Bugs,
	      CVS, CVSup, �s�D, �ӷ~�o���, ����, CTM, Unix"/>
	<link rel="shortcut icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="&enbase;/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" media="screen" href="&base;/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="&base;/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="&enbase;/layout/js/styleswitcher.js"></script>
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD Project �s�D" href="&base;/news/news.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD �w�����i" href="&enbase;/security/advisories.rdf" />
	<link rel="alternate" type="application/rss+xml"
	  title="FreeBSD GNOME Project �s�D" href="&enbase;/gnome/news.rdf" />

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
				  Based on BSD &unix;
				</h1>
				<p>
				  FreeBSD&reg; �O�@�إ��i���@�~�t�ΡA�i�䴩
				  x86 �ۮe(�]�A Pentium&reg; �M Athlon&trade;)�B
				  amd64 �ۮe(�]�A Opteron&trade;�B Athlon&trade;64 �M EM64T)�B
				  UltraSPARC&reg;�B IA-64�B PC-98 �H�� ARM �[�c���q���C
				  �䷽�۩� BSD�A �ѥ[�{�j�ǧB�J�Q���ն}�o�� &unix; �����C �ثe��
				  <a href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/staff-committers.html">���\�h�H�ѻP���}�o�ζ�</a> �Һ��@�C
				  ���~�A��U�� <a href="&base;/platforms/">�w�饭�x</a> ���䴩�{�סA
				  �]�U�ۦ��Ҥ��P�C
				</p>
				<div id="TXTFRONTFEATURELINK">
				&#187;<a href="&base;/about.html" title="�Ѿ\�Ա�">�Ѿ\�Ա�</a>
				</div> <!-- TXTFRONTFEATURELINK -->
			</div> <!-- FRONTFEATURECONTENT -->
		</div> <!-- FRONTFEATURELEFT -->

		<div id="FRONTFEATUREMIDDLE">
			<div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>
				<div class="frontgetcontent">
				  <a href="&base;/where.html">�ߧY���o FreeBSD</a>
				</div> <!-- frontgetcontent -->
			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontgetroundbox -->

			<div id="FRONTRELEASES">
			  <div id="FRONTRELEASESCONTENT" class="txtshortcuts">
				  <h2><a href="&enbase;/releases/"> �̷s���� </a></h2>
				  <ul id="FRONTRELEASESLIST">
					<li>
					  <a href="&enbase;/&u.rel.announce;">Production Release &rel.current;</a>
					</li>
					<li>
					  <a href="&enbase;/&u.rel2.announce;">(�¦�)Production Release &rel2.current;</a>
					</li>
			    <xsl:if test="'&beta.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">�Y�N�o�G
				            &betarel.current; - &betarel.vers;</a>
					</li>
			    </xsl:if>
			    <xsl:if test="'&beta2.testing;' != 'IGNORE'">
					<li>
					  <a href="&base;/where.html#helptest">�Y�N�o�G
				            &betarel2.current; - &betarel2.vers;</a>
					</li>
			    </xsl:if>
				  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		</div> <!-- FRONTFEATUREMIDDLE -->

		<div id="FRONTFEATURERIGHT">
			<h2 class="blockhide">�y��</h2>
			<div id="LANGUAGENAV">
				<ul id="LANGUAGENAVLIST">
				  <li>
					<a href="&enbase;/de/" title="�w�y">de</a>
				  </li>
				  <li>
					<a href="&enbase;/" title="�^�y">en</a>
				  </li>
				  <li>
					<a href="&enbase;/es/" title="��y">es</a>
				  </li>
				  <li>
					<a href="&enbase;/fr/" title="�k�y">fr</a>
				  </li>
				  <li>
					<a href="&enbase;/it/" title="�q�y">it</a>
				  </li>
				  <li>
					<a href="&enbase;/ja/" title="��y">ja</a>
				  </li>
				  <li>
					<a href="&enbase;/ru/" title="�X�y">ru</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/zh_CN/" title="����(²��)">zh_CN</a>
				  </li>
				</ul>
			</div> <!-- LANGUAGENAV -->

			<div id="MIRROR">
			  <form action="&cgibase;/mirror.cgi" method="get">
				<div>
				  <h2 class="blockhide"><label for="MIRRORSEL">Mirror</label></h2>
				  <select id="MIRRORSEL" name="goto">
					  <xsl:call-template name="html-index-mirrors-options-list">
					    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
					  </xsl:call-template>
				  </select>
				</div> <!-- unnamed -->
				<input type="submit" value="Go" />
			  </form>
			</div> <!-- MIRROR -->

			<div id="FRONTSHORTCUTS">
			  <div id="FRONTSHORTCUTSCONTENT" class="txtshortcuts">
				  <h2>�`�γs��</h2>
				  <ul id="FRONTSHORTCUTSLIST">
					<li>
					  <a href="&enbase;/community/mailinglists.html" title="�l��׾�">�l��׾�</a>
					</li>
					<li>
					  <a href="&base;/send-pr.html" title="���i Bug">���i Bug</a>
					</li>
					<li>
					  <a href="&enbase;/doc/zh_TW.Big5/books/faq/index.html" title="FAQ">FAQ</a>
					</li>
					<li>
					  <a href="&enbase;/doc/zh_TW.Big5/books/handbook/index.html" title="Handbook">Handbook</a>
					</li>
					<li>
					  <a href="&enbase;/ports/index.html" title="Ports">Ports</a>
					</li>

				  </ul>
			  </div> <!-- FRONTSHORTCUTSCONTENT -->
			</div> <!-- FRONTSHORTCUTS -->

			<div class="frontnewroundbox">
			  <div class="frontnewtop"><div><b style="display: none">.</b></div></div>
			    <div class="frontnewcontent">
			      <a href="&enbase;/projects/newbies.html">�����x FreeBSD�H</a>
			    </div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
			</div> <!-- frontnewroundbox -->
		</div> <!-- FEATURERIGHT -->

            </div> <!-- FRONTFEATURECONTAINER -->

	    <br class="clearboth" />
            <div id="FRONTNEMSCONTAINER">
            	<div id="FRONTNEWS">
            	   <div id="FRONTNEWSCONTENT" class="txtnewsevent">
			<h2>�s�D</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/news/newsflash.html" title="��h�s�D">��h�s�D</a>
				  </li>
				  <li class="last-child">
					<a href="&base;/news/news.rdf" title="�s�D RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="�s�D RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

            	   </div> <!-- FRONTNEWSCONTENT -->
            	</div> <!-- FRONTNEWS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTEVENTS">
		   <div id="FRONTEVENTSCONTENT" class="txtnewsevent">

			<h2>�������</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-events-items">
				<xsl:with-param name="events.xml-master" select="$events.xml-master" />
				<xsl:with-param name="events.xml" select="$events.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&enbase;/events/" title="��h����">��h����</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTEVENTSCONTENT -->
            	</div> <!-- FRONTEVENTS -->
            	<div class="frontseparator"><b style="display: none">.</b></div>
            	<div id="FRONTMEDIA">
		   <div id="FRONTMEDIACONTENT" class="txtnewsevent">

			<h2>�C�����</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="only-child">
					<a href="&base;/news/press.html" title="��h�C�����">��h�C�����</a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

		   </div> <!-- FRONTMEDIACONTENT -->
            	</div> <!-- FRONTMEDIA -->
		<div class="frontseparator"><b style="display: none">.</b></div>
		<div id="FRONTSECURITY">
		   <div id="FRONTSECURITYCONTENT" class="txtnewsevent">

			<h2>�w�����i</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
				<xsl:with-param name="type" select="'advisory'" />
			</xsl:call-template>

			  <div>
				<ul class="newseventslist">
				  <li class="first-child">
					<a href="&base;/security/" title="��h�w�����i">��h</a>
				  </li>
				  <li class="last-child">
					<a href="&enbase;/security/advisories.rdf" title="�w�����i RSS Feed"><img class="rssimage" src="&enbase;/layout/images/ico_rss.png" width="27" height="12" alt="�w�����i RSS Feed" /></a>
				  </li>
				</ul>
			  </div> <!-- unnamed -->
			</div> <!-- newseventswrap -->

			<br />
			<h2>�ɻ~���i</h2>
			<div class="newseventswrap">

			<xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$notices.xml" />
				<xsl:with-param name="type" select="'notice'" />
			</xsl:call-template>

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

	FreeBSD �лx(Logo)�O FreeBSD
	����|�����U�ӼСC FreeBSD Project ���o�� <a
	  href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">FreeBSD ����|</a>
	���\�i�ӨϥΰӼСC

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
