<?xml version="1.0" encoding="euc-jp"?>

<!-- $FreeBSD: www/ja/share/sgml/templates.usergroups.xsl,v 1.2 2005/09/19 07:58:19 hrs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">

  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/templates.usergroups.xsl" />

  <xsl:output type="xml" encoding="euc-jp"
	      indent="yes"/>

  <!-- template: "html-usergroups-list-header"
       print header part of usergroup listing (l10n) -->

  <xsl:template name="html-usergroups-list-header">
    <p>FreeBSD は広く使われており、世界中にたくさんのユーザグループがあります。
      このリストに載っていないユーザグループをご存知でしたら、
      ぜひ、<a href="http://www.freebsd.org/send-pr.html">障害報告</a
	>の www カテゴリを使ってお知らせください。
      報告はできれば HTML 形式で、簡単な紹介を添えるようにお願いします。</p>

    <h3>地域</h3>
  </xsl:template>

</xsl:stylesheet>
