<!-- $FreeBSD: doc/en_US.ISO_8859-1/books/design-44bsd/freebsd.dsl,v 1.1 2001/03/09 18:05:31 nik Exp $ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl SYSTEM "../../share/sgml/freebsd.dsl" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      ;; Keep the legalnotice together with the rest of the text
      (define %generate-legalnotice-link%
        #f)
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
