<!-- $FreeBSD: doc/zh_TW.Big5/share/sgml/freebsd.dsl,v 1.1 2000/03/23 09:00:17 nik Exp $ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl SYSTEM "../../../share/sgml/freebsd.dsl" CDATA DSSSL>
<!ENTITY % lang.zh.dsssl "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <![ %lang.zh.dsssl; [
        (define %gentext-language% "zh")
      ]]>

      (define %html-header-tags% '(("META" ("HTTP-EQUIV" "Content-Type") ("CONTENT" "text/html; charset=Big5-TW"))))
 
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
