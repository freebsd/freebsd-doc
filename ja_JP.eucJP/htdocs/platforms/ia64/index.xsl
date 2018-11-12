<?xml version="1.0" encoding="EUC-JP" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "FreeBSD/ia64 �ץ�������">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.7 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD'"/>

  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="EUC-JP" method="html"/>
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

		<img align="right" alt="McKinley die" src="&enbase;/platforms/ia64/mckinley-die.png"/>

		<p>freebsd-ia64 �᡼��󥰥ꥹ�ȤΥ��������֤򸡺�:</p>

		<form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
		  <input name="words" size="50" type="text"/>
		  <input name="max" type="hidden" value="25"/>
		  <input name="source" type="hidden" value="freebsd-ia64"/>
		  <input type="submit" value="Go"/>
		</form>

		<h3><a name="toc">�ܼ�</a></h3>

		<ul>
		  <li>
		    <a href="#intro">�Ϥ����</a>
		  </li>
		  <li>
		    <a href="#status">���ߤξ���</a>
		  </li>
		  <li>
		    <a href="todo.html">����</a>
		  </li>
		  <li>
		    <a href="machines.html">�ϡ��ɥ������ꥹ��</a>
		  </li>
		  <li>
		    <a href="refs.html">����ʸ��</a>
		  </li>
		</ul>

		<h3><a name="intro">�Ϥ����</a></h3>

		<p>FreeBSD/ia64 �ץ������ȤΥڡ����ˤϡ������ˤ� Intel
		  Itanium&reg; �ץ��å��ե��ߥ� (IPF) �Ȥ����Τ��Ƥ��� Intel 
		  �� IA-64 �������ƥ�����ؤ� FreeBSD �ΰܿ��˴ؤ�����󤬷Ǻܤ���Ƥ��ޤ���
		  �ܿ����Τ�Τ�Ʊ���������Υڡ����Ϥޤ�����ʬ��������Ǥ���</p>

		<h3><a name="status">���ߤξ���</a></h3>

		<p>ia64 �� FreeBSD �ϡ��ޤ� tier 2 �ץ�åȥե�����ȸ��ʤ���Ƥ��ޤ���
		  �Ĥޤꡢ�������ƥ����ե������꡼�����󥸥˥���
		  �ġ������������ƥʤ�����Ū�ʥ��ݡ��ȤϤ���ޤ��󡣤������ʤ��顢�ºݤ�
		  (����Ū�˥��ݡ��Ȥ����) tier 1 �ץ�åȥե������
		  tier 2 �ץ�åȥե�����ΰ㤤�ϡ�
		  ����ۤɸ�̩�ǤϤ���ޤ���ia64 �Ǥϡ��ۤܤ��٤Ƥ�¦�̤ˤ����ơ�
		  tier 1 �ץ�åȥե������Ʊ���ˤʤäƤ��ޤ���
		  <br/>
		  ��ȯ�Ԥ�Ω��ǹͤ���ȡ�ia64 �Ǥ��⤦���Ф餯 tier 2
		  �ץ�åȥե�����Ǥ��뤳�Ȥˤ�ͭ������������ޤ���
		  �ޤ������Ĥ� ABI ����ߴ����ѹ��������Ƥ��ơ�
		  �ܿ��Τ���ʤ˽����������ߴ�����ݻ����ʤ���Фʤ�ʤ��Ȥ����Τϡ�
		  ����Ū�ȤϤȤƤ⤤���ʤ�����Ǥ���</p>

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
