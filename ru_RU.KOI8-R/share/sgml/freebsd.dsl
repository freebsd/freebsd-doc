<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl SYSTEM "../../../share/sgml/freebsd.dsl" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      (define %gentext-language% "ja")

      (define %html-header-tags% '(("META" ("HTTP-EQUIV" "Content-Type") ("CONTENT" "text/html; charset=koi8-r")))) 
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
