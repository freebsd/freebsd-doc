<?xml version="1.0" encoding="euc-jp" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>

<!-- $FreeBSD$ -->
<!-- Original revision: r51914 -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

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

  <xsl:variable name="svnKeyword">$FreeBSD$</xsl:variable>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:template name="process.content">
	    <div id="frontcontainer">
	      <div id="frontmain">
		<div id="frontfeaturecontainer">

		  <div id="frontfeatureleft">
		    <div id="frontfeaturecontent">
			<h1>&os; �ץ�������</h1>

			<p>&os; �ϡ��ǿ��Υ����С��ǥ����ȥåפ�����Ȥ߹���
			  <a href="&base;/platforms/">�ץ�åȥե�����</a>
			  �ѤΥ��ڥ졼�ƥ��󥰥����ƥ�Ǥ���
			  ¿���� <a href="&enbase;/doc/ja_JP.eucJP/articles/contributors/staff-committers.html">���ߥ�˥ƥ�</a>
			  �� 30 ǯ�ʾ�ˤ��ϤäƳ�ȯ��³���Ƥ��ޤ���
			  ���٤ʥͥåȥ�����������ƥ���
			  ����ӥ��ȥ졼����ǽ�ˤ�ꡢ
			  &os; �Ͽ�¿���� <a
			  href = "&enbase;/doc/ja_JP.eucJP/books/handbook/nutshell.html#introduction-nutshell-users">���絬�ϤΥ����֥�����</a>��
			  ������ڤ��Ƥ����Ȥ߹��ߥͥåȥ�����
			  ���ȥ졼���ǥХ����ˤ��������Ѥ���Ƥ��ޤ���</p>

			<div id="txtfrontfeaturelink">
			  &#187;<a href="&base;/about.html" title="�ܤ����Ϥ�����">�ܤ����Ϥ�����</a>
			</div> <!-- TXTFRONTFEATURELINK -->

			<div id="txtfrontjournalblock">
			  <br/>&#187;
			  <span
			    id="txtfrontjournallink">
			    <a
			      href="http://www.freebsdjournal.com/"
			        title="&os;&nbsp;Journal">&os;&nbsp;Journal</a>
			    ������
			  </span> <!-- TXTFRONTJOURNALLINK -->
			</div> <!-- TXTFRONTJOURNALBLOCK -->

				  <!-- IMPORTANT NOTICES -->
				  <!--
				  <div
				    style="width:640px; margin: 16px 16px 16px 32px; auto">

				    <h2>ANNOUNCEMENT: [header]</h2>

				    <p align="justify">[text]</p>
				  </div>
				  -->
				  <!-- END IMPORTANT NOTICES -->

		    </div> <!-- FRONTFEATURECONTENT -->
		  </div> <!-- FRONTFEATURELEFT -->

		  <div id="frontfeaturemiddle">
		      <div class="frontgetroundbox">
			  <div class="frontgettop"><div><b style="display: none">.</b></div></div>

			<div class="frontgetcontent">
			  <a href="&base;/where.html">&os; �����ꤹ��</a>
			</div> <!-- frontgetcontent -->

			  <div class="frontgetbot"><div><b style="display: none">.</b></div></div>
		      </div> <!-- frontgetroundbox -->

			<div id="frontreleases">
			  <div id="frontreleasescontent" class="txtshortcuts">
			  <h2><a href="&base;/releases/">���ݡ��Ȥ���Ƥ����꡼��</a></h2>
			  <ul id="frontreleaseslist">
			    <li>�ץ���������:&nbsp;<a
				href="&u.rel.announce;">&rel.current;</a>,
				<a
				  href="&u.rel1.announce;">&rel1.current;</a>,
				<a
				  href="&u.rel2.announce;">&rel2.current;</a></li>
			    <xsl:if test="'&beta.upcoming;' != 'IGNORE'">
			    <li>����ͽ��: <a
				href="&u.betarel.schedule;">&betarel.current;</a></li>
			    </xsl:if>
			    <xsl:if test="'&beta2.upcoming;' != 'IGNORE'">
			    <li>����ͽ��: <a
				href="&u.betarel2.schedule;">&betarel2.current;</a></li>
			    </xsl:if>
					<li><a href="&base;/security/security.html#sup">���ݡ��ȥ饤�ե�������</a></li>
			  </ul>
			  </div> <!-- FRONTRELEASESCONTENT -->
			</div> <!-- FRONTRELEASES -->
		  </div> <!-- FRONTFEATUREMIDDLE -->

		<div id="frontfeatureright">
		      <h2 class="blockhide">¾����ؤΥ��</h2>

		      <div id="languagenav">
			<ul id="languagenavlist">
			  <li>
			    <a href="&enbase;/de/" title="�ɥ��ĸ�">de</a>
			  </li>
			  <li>
			    <a href="&enbase;/" title="�Ѹ�">en</a>
			  </li>
			  <li>
			    <a href="&enbase;/ja/" title="���ܸ�">ja</a>
			  </li>
			  <li>
			    <a href="&enbase;/zh_CN/" title="���� (���λ�)">zh_CN</a>
			  </li>
			  <li class="last-child">
			    <a href="&enbase;/zh_TW/" title="���� (���λ�)">zh_TW</a>
			  </li>
			</ul>
		      </div> <!-- LANGUAGENAV -->

		      <div id="frontshortcuts">
			<div id="frontshortcutscontent" class="txtshortcuts">
			  <h2>���硼�ȥ��å�</h2>
			  <ul id="frontshortcutslist">
			    <li>
			      <a href="&base;/community/mailinglists.html" title="�᡼��󥰥ꥹ��">�᡼��󥰥ꥹ��</a>
			    </li>
			    <li>
			      <a href="&base;/support/bugreports.html" title="�㳲���">�㳲���</a>
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
			  <div class="frontnewtop"><div><b style="display: none">.</b></div></div>
			<div class="frontnewcontent">
			  <a href="&base;/projects/newbies.html">FreeBSD �����ƤȤ�������</a>
			</div> <!-- frontnewcontent -->
			  <div class="frontnewbot"><div><b style="display: none">.</b></div></div>
		      </div> <!-- frontnewroundbox -->
			<!-- 25th anniversary logo -->
			<div class="frontfeaturecontent">
			  <!-- XXX: target page not yet ready
			  <a href="XXX TBD"
			    title="&os; 25th Anniversary">
			  -->
			  <img
			    src="&enbase;/layout/images/25thanniversary.png"
			    style="margin-top: 5px;"
			    width="167" height="88"
			    alt="25th Anniversary Logo" />
			  <!--
			  </a>
			  -->
			</div>
			<!-- end 25th anniversary logo -->
		    </div> <!-- FEATURERIGHT -->

		  </div> <!-- FRONTFEATURECONTAINER -->

		  <br class="clearboth" />

		  <div id="frontnemscontainer">
		    <div id="frontnews">
		      <div id="frontnewscontent" class="txtnewsevent">
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

		    <div id="frontevents">
		      <div id="fronteventscontent" class="txtnewsevent">
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

		    <div id="frontmedia">
		      <div id="frontmediacontent" class="txtnewsevent">
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

		    <div id="frontsecurity">
		      <div id="frontsecuritycontent" class="txtnewsevent">
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
  </xsl:template>

  <xsl:template name="process.footer">
	&copyright;

	The mark FreeBSD is a registered trademark of The FreeBSD
	Foundation and is used by The FreeBSD Project with the
	permission of <a
	  href="https://www.freebsdfoundation.org/documents/Guidelines.shtml">The
	FreeBSD Foundation</a>.
	<a href="&base;/mailto.html" title="&header2.word.contact;">&header2.word.contact;</a>
  </xsl:template>
</xsl:stylesheet>
