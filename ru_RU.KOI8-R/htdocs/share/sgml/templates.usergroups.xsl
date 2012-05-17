<?xml version="1.0" encoding="koi8-r"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD Fragment//EN"
                                "http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY title "Группы пользователей">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!-- The FreeBSD Russian Documentation Project -->
<!-- $FreeBSDru: frdp/www/ru/share/sgml/templates.usergroups.xsl,v 1.2 2005/11/03 18:27:42 gad Exp $ -->
<!-- $FreeBSD: www/ru/share/sgml/templates.usergroups.xsl,v 1.1 2005/11/08 18:22:23 bvs Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  exclude-result-prefixes="cvs">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/templates.usergroups.xsl"/>

  <xsl:template name="html-usergroups-list-header">
    <p>Популярность FreeBSD породила некоторое количество групп
      пользователей по всему миру.  Если у вас есть информация о группе
      пользователей FreeBSD, которая здесь не указана, пожалуйста, составьте
      <a href="http://www.freebsd.org/send-pr.html">сообщение о проблеме</a>
      для категории www.  Посылаемое сообщение должны быть в формате HTML и содержать
      краткое описание.</p>
    
    <h3>Регионы</h3>
  </xsl:template>
</xsl:stylesheet>
