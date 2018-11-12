<?xml version="1.0" encoding="euc-jp" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD �Υ��ߥ�˥ƥ�">
]>

<!-- $FreeBSD$ -->
<!-- Original revision: r52000 -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns="http://www.w3.org/1999/xhtml"
  extension-element-prefixes="date">

  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>
  <xsl:import href="http://www.FreeBSD.org/XML/share/xml/xhtml.xsl"/>

  <xsl:variable name="title">&title;</xsl:variable>

  <xsl:key name="last-year-event-by-country" match="event[number(enddate/year) = (number(date:year()) - 1)]"
    use="location/country" />

  <xsl:key name="event-by-year" match="event" use="enddate/year" />

  <xsl:template name="process.sidewrap">
    &nav.community;
  </xsl:template>

  <xsl:template name="process.contentwrap">
		<p>&os; �ˤϡ���ȯ��٤����ȯ�ʥ��ߥ�˥ƥ�������ޤ���</p>

		<p><a href="&base;/community/mailinglists.html"
		      >�᡼��󥰥ꥹ��</a> �ο��� 100 ��Ķ���Ƥ��ꡢ
		  ��������Υ����֥١�����
		  <a href="https://forums.FreeBSD.org/">�ե������</a> �䡢
		  �����Ĥ�� <a
		    href="&enbase;/doc/ja_JP.eucJP/books/handbook/eresources-news.html">�˥塼�����롼��</a>
		  ������ޤ�������
		  <xsl:value-of
		     select="count(document($usergroups.xml)//country)" />
		  �����
		  <xsl:value-of
		     select="count(document($usergroups.xml)//entry)"
		     /><xsl:text> </xsl:text> ��ۤ���
		  <a href="&base;/usergroups.html">�桼�����롼��</a>
		  �����ꡢ
		  <a href="&base;/community/irc.html">IRC</a>
		  �Υ��ߥ�˥ƥ����ȯ�Ǥ���
		  ¿���γ�ȯ�Ԥϡ���Ϣ���� &os; �ξ����
		  <a href="https://planet.freebsdish.org">�֥�</a>
		  �ǾҲ𤷤Ƥ��ޤ���
		  �ޤ�����ȯ�Ԥ��ȯ�ʹ׸��Ԥϡ�
		  &os; �γ�ȯ�������Ϣ�ץ������Ȥξ���� <a
		  href="https://wiki.FreeBSD.org/">wiki</a>
		  �ˤޤȤ�Ƥ��ޤ���</p>

		<p>��ǯ�ϡ�����
		  <xsl:value-of
		     select="count(/events/event[(number(enddate/year) =
			     (number($curdate.year) -1)) and (generate-id() =
			     generate-id(key('last-year-event-by-country',
			     location/country)[1]))])" />
		  ����ǡ�&os; �˴�Ϣ����
		  <xsl:value-of
		     select="count(/events/event[number(enddate/year) =
			     (number($curdate.year) -1)])" />
		  ��Υ��٥�Ȥ����Ť���ޤ�����
		  <a href="&base;/events/events.html">���٥�ȥڡ���</a> �Ǥϡ�
		  ���峫�Ť���� &os; ��Ϣ���٥�Ȥ�
		  <a href="&base;/events/events.ics">������</a> ��
		  <a href="&base;/events/rss.xml">RSS feed</a>
		  ���󶡤��Ƥ��ޤ���
		  ���˳��Ť��줿���٥�Ȥ˴ؤ����¿���Υӥǥ�����
		  YouTube �� <a
		href="https://www.youtube.com/bsdconferences">BSD
		    Conferences</a> ����ͥ�Ǹ�������Ƥ��ޤ���</p>

<!-- The Latest Videos section is placed inside an invisible block, which
     is only made visible if the browser supports Javascript. -->

		<div id="latest-videos" style="display:none;">
		  <h3>�ǿ��ӥǥ�</h3>

<!-- See http://www.google.com/uds/solutions/wizards/videobar.html -->
		  <div id="videoBar-bar">
		    <span style="color:#676767;font-size:11px;margin:10px;padding:4px;">Loading...</span>
		  </div>

		  <script src="//www.google.com/uds/api?file=uds.js&amp;v=1.0&amp;source=uds-vbw"
			  type="text/javascript"></script>
		  <style type="text/css">
		    @import url("//www.google.com/uds/css/gsearch.css");
		  </style>
  <!-- Video Bar Code and Stylesheet -->
		  <script type="text/javascript">
		    window._uds_vbw_donotrepair = true;
		  </script>
		  <script src="//www.google.com/uds/solutions/videobar/gsvideobar.js?mode=new"
			  type="text/javascript"></script>
		  <style type="text/css">
		    @import url("//www.google.com/uds/solutions/videobar/gsvideobar.css");
		  </style>

		  <style type="text/css">
		    .playerInnerBox_gsvb .player_gsvb {
		      width : 320px;
		      height : 260px;
		    }
		  </style>

		  <script type="text/javascript">
		    document.getElementById('latest-videos').style.display = 'block';

		    function LoadVideoBar() {

		      var videoBar;
		      var options = {
			largeResultSet : !true,
			horizontal : true,
			autoExecuteList : {
			  cycleTime : GSvideoBar.CYCLE_TIME_MEDIUM,
			  cycleMode : GSvideoBar.CYCLE_MODE_LINEAR,
			  executeList : ["ytchannel:bsdconferences"]
			}
		      }

		      videoBar = new GSvideoBar(document.getElementById("videoBar-bar"),
                      GSvideoBar.PLAYER_ROOT_FLOATING,
                      options);
		    }
    // arrange for this function to be called during body.onload
    // event processing
		    GSearch.setOnLoadCallback(LoadVideoBar);
		  </script>
		</div> <!-- Latest Videos -->
	      <h2>���������ͥåȥ��</h2>
	      <p>&os; �Ϥ��ޤ��ޤʥ��������ͥåȥ����ɽ������Ƥ��ޤ���</p>
	      <ul>
		<li><a href="http://www.flickr.com">flickr</a> �Ǥϡ�
		�桼�����롼�ץߡ��ƥ��󥰡�
		����ե���󥹤���ӥϥå�����ο����μ̿���
		'<a
		href="https://flickr.com/search/?z=t&amp;ss=2&amp;w=all&amp;q=freebsd&amp;m=text">freebsd</a>'
		�������դ����Ƥ��ޤ���</li>

		<li><a href="https://www.youtube.com">YouTube</a> �ˤϡ�
		������ <a
		href="https://www.youtube.com/results?search_query=freebsd">&os;</a>
		�˴�Ϣ��������ե���󥹡�
		�����꡼�󥭥㥹�Ȥ���ӥǥ�󥹥ȥ졼�����Υӥǥ�������ޤ���
		�äˡ�������
		<a href="https://www.youtube.com/bsdconferences">BSD
		Conferences</a> ����ͥ�Ǥϡ�
		FreeBSD �ƥ��˥��륫��ե���󥹤�
		1 ���ֵ��ϤΥץ쥼��ơ��������ά�ʤ����뤳�Ȥ��Ǥ��ޤ���</li>

		<li><a href="https://www.facebook.com">Facebook</a> �ˤ� <a
		href="https://www.facebook.com/groups/FreeSBD/">FreeBSD
		Users Group</a>,
		<a href="https://www.linkedin.com">LinkedIn</a>	�ˤ�
		<a href="https://www.linkedin.com/groups?gid=47628">FreeBSD
		Group</a> ������ޤ���</li>

		<li><a href="https://twitter.com">Twitter</a> ��
		<a href="https://twitter.com/freebsd">@freebsd</a>,
		<a href="https://twitter.com/freebsdhelp">@freebsdhelp</a>,
		<a href="https://twitter.com/freebsdblogs">@freebsdblogs</a> �ޤ���
		<a href="https://twitter.com/freebsdcore">@freebsdcore</a>
		��ե������Ƥ���������</li>
	      </ul>
  </xsl:template>
</xsl:stylesheet>
