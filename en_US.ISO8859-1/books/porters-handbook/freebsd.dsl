<!-- $FreeBSD: doc/en_US.ISO_8859-1/books/porter-handbook/freebsd.dsl,v 1.1 2000/04/22 23:47:26 nik Exp $ -->

<!-- Local DSSSL file for the Porter's Handbook.  This is so we can include
     a link to the -ports mailing list at the bottom of the HTML files, 
     rather than the -questions mailing list. -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl SYSTEM "../../share/sgml/freebsd.dsl" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      <![ %output.html; [ 
	(define ($email-footer$)
          (make sequence
            (literal "For questions about the FreeBSD ports system, e-mail <")
            (make element gi: "a"
                  attributes: (list (list "href" "mailto:ports@freebsd.org"))
              (literal "ports@freebsd.org"))
            (literal ">.")
            (make empty-element gi: "br")
            (literal "For questions about this documentation, e-mail <")
              (make element gi: "a"
                    attributes: (list (list "href" "mailto:doc@freebsd.org"))
                (literal "doc@freebsd.org"))
	      (literal ">."))) 
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
