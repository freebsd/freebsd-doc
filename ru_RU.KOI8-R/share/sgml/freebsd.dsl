<!-- $FreeBSD: doc/ru_RU.KOI8-R/share/sgml/freebsd.dsl,v 1.3 2000/09/28 23:29:47 nbm Exp $ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
<!ENTITY % lang.ru.dsssl "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <![ %lang.ru.dsssl; [
        (define %gentext-language% "ru")
      ]]>

      (define %html-header-tags% '(("META" ("HTTP-EQUIV" "Content-Type") ("CONTENT" "text/html; charset=koi8-r")))) 
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
