<!-- $FreeBSD: doc/ja_JP.eucJP/share/sgml/freebsd.dsl,v 1.1 2000/03/23 09:00:13 nik Exp $ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl SYSTEM "../../../share/sgml/freebsd.dsl" CDATA DSSSL>
<!ENTITY % lang.ja.dsssl "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <![ %lang.ja.dsssl; [
	(define %gentext-language% "ja")
      ]]>

      (define %html-header-tags% '(("META" ("HTTP-EQUIV" "Content-Type") ("CONTENT" "text/html; charset=EUC-JP")))) 
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
