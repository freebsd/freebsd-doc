<?xml version="1.0" encoding="euc-jp"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "FreeBSD/ia64 �ץ�������">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: 1.11 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD$'"/>

  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="euc-jp" method="html"/>

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

		<img align="right" alt="Montecito die" src="&enbase;/platforms/ia64/montecito-die.png"/>

		<p>FreeBSD/ia64 �㳲���ǡ����١����򸡺�����:</p>

	<form action="http://www.FreeBSD.org/cgi/query-pr-summary.cgi"
	      method="get">
	    <input type="hidden" name="category" value="ia64"/>
	    <input type="hidden" name="sort" value="none"/>
	    <input type="text" name="text"/>
	    <input type="submit" value="Go"/>
		</form>

	<h3>
	  ����
	</h3>
	<p>
	  ���Υڡ����ϡ�
	  �����Ǥ��뤳�Ȥ�õ���Ƥ���͡��Τ���ν�ȯ���Ȥ��褦�Ȥ��Ƥ����ΤǤ���
	  �ڡ�����γƹ��ܤϡ���̩��ͥ���̤ι⤤����¤�Ǥ���櫓�ǤϤ���ޤ��󤬡�
	  �ۤܤ��ν��֤ˤʤäƤ��ޤ������٤����Ȥˤϡ������˽Ҥ٤��ƤϤ��ʤ���Τ⡢
	  �����󤢤�ޤ������Ȥ��С����� ia64 �ǥ����֥ڡ������ݼ�����ʤɤ������Ǥ�...��
	</p>

	<h4>
	  tier 1 �ץ�åȥե�����Ȥʤ뤳��
	</h4>
	<p>
	  tier 2 �ץ�åȥե�����Ȥ��� 2 �ĤΥ�꡼����Ф���
	  tier 1 �ץ�åȥե�����Ȥʤ�٤���Ȥ�������Ǥ���
	  ���Τ���ˤϡ����Τ褦�ʤ��ޤ��ޤʲ��꤬����ޤ���
	</p>
	<ul>
	  <li>
	    ���󥹥ȡ��������������ơ����Ǥ� GPT ����
	    ¾�Υ��ڥ졼�ƥ��󥰥����ƥब�ޤޤ�� EFI
	    �ѡ��ƥ������ȶ��ˤ�������θ����褦�ˤ��ޤ���
	    ����� EFI �֡��ȥ�˥塼�� FreeBSD �Υ���ȥ���ɲäǤ���褦�ˤǤ���С�
	    ˾�ޤ����Ǥ��礦��
	  </li>
	  <li>
	    GNU �ǥХå���ܿ����ޤ�����ǰ�ʤ��鳫ȯ�ѥޥ���ǻȤ����Ȥ��Ǥ��Ƥ��ޤ���
	    �ޤ���tier 1 �ץ�åȥե�����ˤ�ɬ�פǤ���
	  </li>
	  <li>
	    X ������ (ports/x11/XFree86-4-Server) ��ܿ����ޤ���tier 1 
	    �Ȥʤ�ˤ�ɬ������ɬ�פǤϤ���ޤ��󤬡�ia64
	    ��ǥ����ȥåץޥ���Ȥ��ƻȤ�������С�
	    ����ʤ��Ǥϡ�����Ǥ��ʤ��Ǥ��礦��
	  </li>
	</ul>

	<h4>
	  ports ����� packages
	</h4>
	<p>
	  FreeBSD �� ia64 �ˤ���������������ΤˤȤƤ���פʤ��Ȥϡ�ls(1) 
	  �ʳ��˲����桼������ư������Τ����뤳�ȤǤ����錄�������ε���� Ports 
	  Collection �ϡ��ۤȤ�ɤ� ia32 ���оݤˤ��Ƥ��ꡢ
	  ia64 �ǹ��ۤǤ��ʤ��ä��ꡢư��ʤ��ä��ꤷ�Ƥ�ճ��ǤϤ���ޤ���
	  �ʤˤ��������ͳ�ǹ��ۤǤ��ʤ� ports �κǿ��Υꥹ�ȤˤĤ��Ƥϡ�
	  <a href="http://pointyhat.FreeBSD.org/errorlogs/ia64-8-latest/">
	    ����
	  </a>
	  �������������������������ۤ˼��Ԥ��� ports �˰�¸���Ƥ��� ports 
	  �Ϲ��ۤ��줺��������Ȥ���Ƥ��ʤ����Ȥ���դ��Ƥ���������
	  ��������� ports ����¸���Ƥ��� ports �κ�Ȥ򤷤Ƥ���������ȡ�
	  ���˽�����ޤ� (ɽ��� "Aff." �������������)��
	</p>

	<h4>
	  �Ϥ򸦤�
	</h4>
	<p>
	  �礱�Ƥ��뵡ǽ���󶡤��뤿��ˡ�®�٤��ϴ�����θ�����˽񤫤줿�ؿ�
	  (�ä˥�����֥�롼����) ���������󤢤�ޤ������δؿ���ƶ�̣���ơ�
	  ɬ�פʤ��ľ�����Ȥϡ��ۤ��γ�ư��Ʊ��������Ω�ˤ����ʤ�������Ǥʤ���
	  ������μ���и����ʤ��Ƥ��ǽ�ʺ�ȤǤ���
	</p>

	<h4>
	  ������γ�ȯ
	</h4>
	<p>
	  ư���ʤ��ä��ꡢ¸�ߤ��Ƥ��ʤ��ä��ꤹ����٥�Τ�Τ˲ä��ơ�
	  ���פ���ʬ�ˤϤ��ʣ���ʽ�ľ����ɬ�פǤ��ꡢ
	  ¾�Υץ�åȥե����ह�٤Ƥ˱ƶ��򤪤�ܤ���ǽ���������Τ⤢��ޤ���
	  ���Ȥ��С����ˤ�����褦�ʤ�ΤǤ���
	</p>
	<ul>
	  <li>
	    PMAP �⥸�塼�����ɤ��� UP ����� SMP �ΰ���������夷�ޤ���
	    VM �Ѵ������٥�Ǥμ�갷�����������ɬ�פ�����ޤ���
	    ����ˤϡ�����������ǽ��ξ����ɬ�פǤ���
	  </li>
	  <li>
	    ia64 �ޥ���ϸŤ��ǥХ������б����Ƥ��ʤ����ᡢsio(4) ��
	    syscons(4) �Τ褦�ʴ���Ū�ʥǥХ����ɥ饤�Ф�ư���ޤ���
	    ��������ץ�åȥե�����˱ƶ����������Υ��֥����ƥ�� (��)
	    ��ʬ���ľ�����Ȥˤʤ뤫�⤷��ʤ�������礭������Ǥ���
	    ���餫�˹��ϰϤˤ錄��Ĵ����ɬ�פʲ���Ǥ���
	  </li>
	  <li>
	    �����ɥ쥹���ڡ����ˤ���� VM �ơ��֥���餺�ˡ�
	    ¸�ߤ������Ρֲ��פ��оݤȤ���褦�ˤ��ơ�
	    �¤� (ʪ��) ���깽�����ꤦ�ޤ���갷���褦�ˤ��ޤ�������Τ���ˡ�
	    ���ߤϥ����̵�뤷�Ƥ��ޤ���
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
